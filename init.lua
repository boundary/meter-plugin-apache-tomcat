-- [boundary.com] Tomcat Metrics using default Manager Web Application
-- [author] Gabriel Nicolas Avellaneda <avellaneda.gabriel@gmail.com>

local boundary = require('boundary')
local http = require('http')
local base64 = require('./modules/mime')
local timer = require('timer')
local string = require('string')
local table = require('table')
local os = require('os')
local fs = require('fs')
local parser = require('./modules/parser')
local math = require('math')

-- default parameter values
local host = 'localhost'
local port = 8080
local path = '/manager/status'
local username = 'admin'
local password = 'password'
local source = os.hostname()
local pollInterval = 5000

-- try to get parameters from plugin instance
if (boundary.param ~= nil) then
 host = boundary.param['host'] or host
 port = boundary.param['port'] or port
 path = boundary.param['path'] or path
 username = boundary.param['username'] or username
 password = boundary.param['password'] or password
 pollInterval = boundary.param['pollInterval'] or pollInterval
 source = boundary.param['source'] or source
end

print("_bevent:Boundary Tomcat Manager Status plugin : version 1.0|t:info|tags:tomcat,plugin")

-- Some helper functions
function base64Encode(s)                                                      
	return base64.b64(s)                                                      
end                                                                           

function isEmpty(s)
	return s == '' or s == nil
end

function currentTimestamp()
	return os.time()
end

function round(val, decimal)
	if (decimal) then
		return math.floor( (val * 10^decimal) + 0.5) / (10^decimal)
	else
	    return math.floor(val+0.5)
	end
end

function authHeader(username, password)                                       
	return {Authorization = 'Basic ' .. 
				base64Encode(username .. ':' .. password)}
end                                                                           

function parse(data)

	local vals = parser.parse(data) 

	return vals
end

local headers = {}
if not isEmpty(username) then
	headers = authHeader(username, password)
end

local reqOptions = {                                                         
	host = host,                                                             
 	port = port,                                                             
 	path = path,                                                             
 	headers = headers
}

function poll()

	getStatus(reqOptions,
		function (data)
			local vals = parse(data)
			report(vals, source, currentTimestamp())
		end)
	timer.setTimeout(pollInterval, poll)
end

function formatMetric(metric, value, source, timestamp)
	return string.format('%s %1.2f %s %s', metric, round(value, 2), source, timestamp)
end

function report(metrics, source, timestamp)
	for metric, value in pairs(metrics) do
		print(formatMetric(metric, value, source, timestamp))
	end
end

function getStatus(reqOptions, successFunc)                                 
	local req = http.request(                                           
		reqOptions,                                                         
		function (res)                                                      
			local data = ''                                             
	                        	                                                                                            
	        res:on('error', function(err)                               
	        	msg = tostring(err)                                 
	        	print('Error while receiving a response: ' .. msg)  
	        end)                                                        
	                        	                                	                                                                                                                                            
	        res:on('data', function(chunk)                              
	        	data = data .. chunk                                
	        end)                                                        
	        
	       	res:on('end', function()                                    
	       		successFunc(data)                                   
	       	end)                                                        
	       
		end)                                                                
	      
	req:on('error', function(err)                                       
		msg = tostring(err)                                         
	   	print('Error while sending a request: ' .. msg)             
	end)                                                                
	     
	req:done()                                                          
end 

-- Start pooling for metrics
poll()
