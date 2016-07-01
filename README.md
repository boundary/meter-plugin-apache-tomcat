# TrueSight Pulse Apache Tomcat Plugin 

Collects metrics from a Apache Tomcat instances

### Prerequisites

|     OS    | Linux | Windows | SmartOS | OS X |
|:----------|:-----:|:-------:|:-------:|:----:|
| Supported |   v   |    v    |    v    |  v   |



#### Boundary Meter versions v4.2 or later

- To install new meter go to Settings->Installation or [see instructions](https://help.boundary.com/hc/en-us/sections/200634331-Installation).
- To upgrade the meter to the latest version - [see instructions](https://help.boundary.com/hc/en-us/articles/201573102-Upgrading-the-Boundary-Meter).

### Plugin Setup

In order for the plugin to collect statistics from Tomcat you need to configure  JMX endpoint for Tomcat installed.To set the CATALINA_OPTS environment variable(assuming JMX endpoint as  8999 of your localhost)
- On Windows:
 	- set CATALINA_OPTS="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=8999 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -Djava.rmi.server.hostname=localhost";
 	
- On Linux:
	- $ CATALINA_OPTS="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=8999 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -Djava.rmi.server.hostname=localhost";
	- $ export CATALINA_OPTS; 	

### Plugin Configuration Fields

|Field Name    | Description                                                                                              |
|:-------------|:---------------------------------------------------------------------------------------------------------|
| Host          | Host of the Tomcat JMX endpoint                |
| Port          | Port of the Tomcat JMX endpoint. Defaults to 8999         |
| Username      | Username to access the Tomcat JMX endpoint |
| Password      | Password to access the Tomcat JMX endpoint |
| Source        | The Source to display in the legend for the metrics data.  It will default to the hostname of the server.|
| Poll Interval | How often should the plugin poll for metrics. |

### Metrics Collected

| Metric Name | Description |
|:------------|:-----------:|
|TOMCAT_JVM_FREE_MEMORY | Free memory of the JVM in MBytes.|
|TOMCAT_JVM_TOTAL_MEMORY | Total memory of the JVM in Mbytes.|
|TOMCAT_HTTP_CURRENT_THREAD_COUNT | Current thread count|
|TOMCAT_HTTP_CURRENT_THREAD_BUSY | Current thread busy|
|TOMCAT_HTTP_MAX_PROCESSING_TIME| Maximum processing time reached for requests (ms)|
|TOMCAT_HTTP_REQUEST_COUNT| Total numbers of requests counter|
|TOMCAT_HTTP_ERROR_COUNT| Total numbers of errors counter|
|TOMCAT_HTTP_BYTES_SENT| Total bytes sent in MB|
|TOMCAT_HTTP_BYTES_RECEIVED| Total bytes received in MB|
|TOMCAT_MEMPOOL_HEAP_EDEN_SPACE| Eden Space Heap memory pool usage |
|TOMCAT_MEMPOOL_HEAP_OLD/TENURED_GEN| Old/Tenured Gen Heap memory pool usage|
|TOMCAT_MEMPOOL_HEAP_SURVIVOR_SPACE| Survivor Space memory pool usage|
|TOMCAT_MEMPOOL_NONHEAP_PERM_GEN| CMS Perm Gen Non-heap memory pool usage|
|TOMCAT_MEMPOOL_NONHEAP_METASPACE| Metaspace Non-heap memory pool usage|
|TOMCAT_MEMPOOL_NONHEAP_CODE_CACHE| Code Cache memory pool usage|

### Dashboards

|Dashboard|Description                                     |
|:--------|:-----------------------------------------------|
| Tomcat HTTP Service | HTTP Metrics for the Tomcat Service |
| Tomcat Memory Pool Summary | Memory Pools of Tomcat Service |

### References

http://tomcat.apache.org/
