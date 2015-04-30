-- [boundary.com] Tomcat Metrics using default Manager Web Application
-- [author] Gabriel Nicolas Avellaneda <avellaneda.gabriel@gmail.com>
local framework = require('./modules/framework')
local Plugin = framework.Plugin
local WebRequestDataSource = framework.WebRequestDataSource
local string = require('string')

local round = framework.util.round
local auth = framework.util.auth

local function parseMetric(data, pattern)
  local _, _, val = string.find(data, pattern)
  p(val)

  return tonumber(round(val, 2))
end

local function parse(data)
  local vals = {}

  vals['TOMCAT_JVM_FREE_MEMORY'] = parseMetric(data, 'Free memory: (%d+%.%d+) MB')
  vals['TOMCAT_JVM_TOTAL_MEMORY'] = parseMetric(data, 'Total memory: (%d+%.%d+) MB')
  vals['TOMCAT_HTTP_CURRENT_THREAD_COUNT'] = parseMetric(data, 'Current thread count: (%d+)')
  vals['TOMCAT_HTTP_CURRENT_THREAD_BUSY'] = parseMetric(data, 'Current thread busy: (%d+)')
  vals['TOMCAT_HTTP_MAX_PROCESSING_TIME'] = parseMetric(data, 'Max processing time: (%d+) ms')
  vals['TOMCAT_HTTP_REQUEST_COUNT'] = parseMetric(data, 'Request count: (%d+)')
  vals['TOMCAT_HTTP_ERROR_COUNT'] = parseMetric(data, 'Error count: (%d+)')
  vals['TOMCAT_HTTP_BYTES_SENT'] = parseMetric(data, 'Bytes sent: (%d+%.%d+) MB')
  vals['TOMCAT_HTTP_BYTES_RECEIVED'] = parseMetric(data, 'Bytes received: (%d+%.%d+) MB')
  vals['TOMCAT_MEMPOOL_HEAP_CMS_OLD_GEN'] = parseMetric(data, 'CMS Old Gen</td><td>Heap memory</td><td>%d+%.%d+ MB</td><td>%d+%.%d+ MB</td><td>%d+%.%d+ MB</td><td>%d+%.%d+ MB %((%d+)%%%)</td>')
  vals['TOMCAT_MEMPOOL_HEAP_EDEN_SPACE'] = parseMetric(data, 'Eden Space</td><td>Heap memory</td><td>%d+%.%d+ MB</td><td>%d+%.%d+ MB</td><td>%d+%.%d+ MB</td><td>%d+%.%d+ MB %((%d+)%%%)</td>')
  vals['TOMCAT_MEMPOOL_HEAP_SURVIVOR_SPACE'] = parseMetric(data, 'Survivor Space</td><td>Heap memory</td><td>%d+%.%d+ MB</td><td>%d+%.%d+ MB</td><td>%d+%.%d+ MB</td><td>%d+%.%d+ MB %((%d+)%%%)</td>')
  vals['TOMCAT_MEMPOOL_NONHEAP_CMS_PERM_GEN'] = parseMetric(data, 'CMS Perm Gen</td><td>Non%-heap memory</td><td>%d+%.%d+ MB</td><td>%d+%.%d+ MB</td><td>%d+%.%d+ MB</td><td>%d+%.%d+ MB %((%d+)%%%)</td>')
  vals['TOMCAT_MEMPOOL_NONHEAP_CODE_CACHE'] = parseMetric(data, 'Code Cache</td><td>Non%-heap memory</td><td>%d+%.%d+ MB</td><td>%d+%.%d+ MB</td><td>%d+%.%d+ MB</td><td>%d+%.%d+ MB %((%d+)%%%)</td>')

  return vals
end

local params = framework.params
params.name = 'Boundary Tomcat plugin'
params.version = '1.1'

local options = {}
options.host = params.host
options.port = params.port
options.path = params.path
options.source = params.source
options.auth = auth(params.username, params.password)
--options.waint_for_end = true
-- TODO: Specify protocol?

local data_source = WebRequestDataSource:new(options)
--data_source:on('data', p)
local plugin = Plugin:new(params, data_source)
function plugin:onParseValues(data, extra)
  if extra.status_code < 200 or extra.status_code >= 300 then
    self:error('HTTP Status Code ' .. extra.status_code)
    return 
  end

  local vals = parse(data)
  return vals
end

plugin:run()
