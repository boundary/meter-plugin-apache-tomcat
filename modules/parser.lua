local fs = require('fs')
local string = require('string')

local parser = {}

function parseMetric(data, pattern, start)

	local s, e, val = string.find(data, pattern)

	return tonumber(val)
end


function parser.parse(data)
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

return parser
