local fs = require('fs')
local parser = require('../modules/parser')

function should_parse_metrics()
	
	local data = fs.readFileSync('status.html')
	local vals = parser.parse(data)

	assert(vals['TOMCAT_JVM_FREE_MEMORY'] == 10.38) 
	assert(vals['TOMCAT_JVM_TOTAL_MEMORY'] == 24.17)
	assert(vals['TOMCAT_HTTP_CURRENT_THREAD_COUNT'] == 10)
	assert(vals['TOMCAT_HTTP_CURRENT_THREAD_BUSY'] == 1)
	assert(vals['TOMCAT_HTTP_MAX_PROCESSING_TIME'] == 248)
	assert(vals['TOMCAT_HTTP_REQUEST_COUNT'] == 70)
	assert(vals['TOMCAT_HTTP_ERROR_COUNT'] == 1)
	assert(vals['TOMCAT_HTTP_BYTES_SENT'] == 0.81)
	assert(vals['TOMCAT_HTTP_BYTES_RECEIVED'] == 0.00)
	assert(vals['TOMCAT_MEMPOOL_HEAP_CMS_OLD_GEN'] == 16)
	assert(vals['TOMCAT_MEMPOOL_HEAP_EDEN_SPACE'] == 0)
	assert(vals['TOMCAT_MEMPOOL_HEAP_SURVIVOR_SPACE'] == 0)
	assert(vals['TOMCAT_MEMPOOL_NONHEAP_CMS_PERM_GEN'] == 15)
	assert(vals['TOMCAT_MEMPOOL_NONHEAP_CODE_CACHE'] == 8)

end

should_parse_metrics()
