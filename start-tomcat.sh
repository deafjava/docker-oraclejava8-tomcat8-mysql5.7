#!/bin/bash
exec $TOMCAT_HOME/bin/catalina.sh jpda run && tail -F $TOMCAT_HOME/logs/catalina.out
