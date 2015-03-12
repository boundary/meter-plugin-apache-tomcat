boundary-tomcat-manager-plugin
------------------------------
A Boundary plugin that collects metrics from the Tomcat default [Manager Web Application](http://tomcat.apache.org/tomcat-7.0-doc/manager-howto.html).

###Supported OS

|   OS    | Linux | Windows | OS X|
|:-------:|:-----:|:-------:|:---:|
|Supported|   v   |    v    |  v  |

#### Boundary Meter Versions V4.0 Or Greater REQUIRED

To get the new meter:

    curl -fsS \
        -d "{\"token\":\"<your API token here>\"}" \
        -H "Content-Type: application/json" \
        "https://meter.boundary.com/setup_meter" > setup_meter.sh
    chmod +x setup_meter.sh
    ./setup_meter.sh

Tomcat server must be configured to run the **manager app**

### Plugin Setup

The Boundary Tomcat Server plugin depends on the manager app module for collecting metrics. The sections below provide the procedures to enable and configure the server-stats module.

##### Install the Tomcat Manager Webapp:

    sudo apt-get install tomcat7-admin

##### Configure user roles

 To access "Manager" you have to configure *manager-gui* role for a user inside the tomcat-users.xml

 Just add the below lines[change username & pwd]:

    <role rolename="manager-gui"/>
    <user username="admin" password="password" roles="manager-gui"/>

##### Restart tomcat 7 server
    sudo service tomcat7 restart

Then verify that statistics are being collected by visiting http://yourserver.com/manager/status

#### Plugin Configuration Fields

|Setting Name          |Identifier      |Type     |Description                                                                              |
|:---------------------|----------------|---------|:----------------------------------------------------------------------------------------|
|Host                  |host            |string   |The host name to gain access to the admin manager                                        |
|Port                  |port            |string   |The host port to gain access to the admin manager                                        |
|Path                  |path            |string   |The URI path to gain access to the admin manager                                         |
|User Name             |username        |string   |The user name to gain access to the admin manager                                        |
|Password              |password        |string   |The password to gain access to the admin manager                                         |
|Poll Interval         |pollInterval    |integer  |How often (in milliseconds) to poll the Apache Tomcat node for metrics (default: 5000).  |

### Metrics Collected
Tracks the following metrics for Apache Tomcat

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
|TOMCAT_MEMPOOL_HEAP_EDEN_SPACE| Eden Space Heap memory pool usage (%)|
|TOMCAT_MEMPOOL_HEAP_CMS_OLD_GEN| CMS Old Gen Heap memory pool usage (%)|
|TOMCAT_MEMPOOL_HEAP_SURVIVOR_SPACE| Survivor Space memory pool usage (%)|
|TOMCAT_MEMPOOL_NONHEAP_CMS_PERM_GEN| CMS Perm Gen Non-heap memory pool usage (%)|_
|TOMCAT_MEMPOOL_NONHEAP_CODE_CACHE| Code Cache memory pool usage (%)|

### References

http://tomcat.apache.org/
