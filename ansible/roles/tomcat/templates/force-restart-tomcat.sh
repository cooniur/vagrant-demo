#!/bin/bash

{{tomcat_dir}}/{{tomcat_version}}/bin/catalina.sh stop 10 -force

{{tomcat_dir}}/{{tomcat_version}}/bin/catalina.sh start