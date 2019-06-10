#!/bin/sh
## java env
#export JAVA_HOME=/usr/local/jdk/jdk1.8.0_101
#export JRE_HOME=$JAVA_HOME/jre


JAVA_OPTIONS_INIT=-Xms64M
JAVA_OPTIONS_MAX=-Xmx256M
JAVA_OPTS=" -Dprogram.name=$SERVER_NAME -Djava.awt.headless=true -Djava.net.preferIPv4Stack=true "
JAVA_JMX_OPTS=" -Dcom.sun.management.jmxremote.port=1099 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false "

APP_NAME=${project.build.finalName}
MAIN_CLASS=${main_class}

JAR_NAME=$APP_NAME\.jar
#PID  代表是PID文件
PID=$APP_NAME\.pid

cd `dirname $0`
BASE_PATH=`pwd`

cd ..
DEPLOY_DIR=`pwd`
DEPLOY_CONF_DIR=$DEPLOY_DIR/conf

CONF_DIR=$DEPLOY_CONF_DIR
LIB_DIR=$DEPLOY_DIR/lib
APP_JAR=$DEPLOY_DIR/$JAR_NAME

echo $LIB_DIR:$CONF_DIR:$APP_JAR $MAIN_CLASS

nohup java  -classpath $LIB_DIR:$CONF_DIR:$APP_JAR $MAIN_CLASS>/dev/null 2>&1 &

#使用说明，用来提示输入参数
usage() {
    echo "Usage: sh 执行脚本.sh [start|stop|restart|status]"
    exit 1
}

#检查程序是否在运行
is_exist(){
  pid=`ps -ef|grep $JAR_NAME|grep -v grep|awk '{print $2}' `
  #如果不存在返回1，存在返回0     
  if [ -z "${pid}" ]; then
   return 1
  else
    return 0
  fi
}

#启动方法
start(){
  is_exist
  if [ $? -eq "0" ]; then 
    echo ">>> ${JAR_NAME} is already running PID=${pid} <<<" 
  else 
    nohup java $JAVA_OPTS $JAVA_OPTIONS_INIT $JAVA_OPTIONS_MAX $JAVA_JMX_OPTS -classpath $LIB_DIR:$CONF_DIR:$APP_JAR $MAIN_CLASS>/dev/null 2>&1 &
    echo $! > $PID
    echo ">>> start $JAR_NAME successed PID=$! <<<" 
   fi
  }

#停止方法
stop(){
  #is_exist
  pidf=$(cat $PID)
  #echo "$pidf"  
  echo ">>> api PID = $pidf begin kill $pidf <<<"
  kill $pidf
  rm -rf $PID
  sleep 2
  is_exist
  if [ $? -eq "0" ]; then 
    echo ">>> api 2 PID = $pid begin kill -9 $pid  <<<"
    kill -9  $pid
    sleep 2
    echo ">>> $JAR_NAME process stopped <<<"  
  else
    echo ">>> ${JAR_NAME} is not running <<<"
  fi  
}

#输出运行状态
status(){
  is_exist
  if [ $? -eq "0" ]; then
    echo ">>> ${JAR_NAME} is running PID is ${pid} <<<"
  else
    echo ">>> ${JAR_NAME} is not running <<<"
  fi
}

#重启
restart(){
  stop
  start
}

#根据输入参数，选择执行对应方法，不输入则执行使用说明
case "$1" in
  "start")
    start
    ;;
  "stop")
    stop
    ;;
  "status")
    status
    ;;
  "restart")
    restart
    ;;
  *)
    usage
    ;;
esac
exit 0