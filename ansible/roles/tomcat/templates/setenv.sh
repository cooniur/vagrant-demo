#!/bin/bash

export CATALINA_OUT="{{tomcat_log_dir}}/catalina.out"

{% if tomcat_java_opts is defined %}
JAVA_OPTS="{{ tomcat_java_opts }}"
{% endif %}