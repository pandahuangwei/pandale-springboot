@echo off & setlocal enabledelayedexpansion
title ${project.build.finalName}
set MAIN_JAR=;..\${project.build.finalName}.jar
rem ${main_class}需要在pom.xml标签<properties>下定义属性
set MAIN_CLASS=${main_class}
set LIB_JARS=""

rem 返回上一层的依赖lib目录下
cd ..\lib

for %%i in (*) do set LIB_JARS=!LIB_JARS!;..\lib\%%i


cd %~dp0
cd ..\bin

if ""%1"" == ""debug"" goto debug
if ""%1"" == ""jmx"" goto jmx


rem echo ff "%1"
rem  aa %LIB_JARS%
rem  cur path  %cd%

set ALL_LIB_JAR=%LIB_JARS%%MAIN_JAR%

echo ALL_LIB_JAR %ALL_LIB_JAR%

java -Xms64m -Xmx1024m -XX:MaxPermSize=64M -classpath %ALL_LIB_JAR%;..\conf %MAIN_CLASS%

goto end
pause
:debug
java -Xms64m -Xmx1024m -XX:MaxPermSize=64M -Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n -classpath ..\conf;%LIB_JARS% %MAIN_CLASS%
goto end

:jmx
java -Xms64m -Xmx1024m -XX:MaxPermSize=64M -Dcom.sun.management.jmxremote.port=1099 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -classpath ..\conf;%LIB_JARS% %MAIN_CLASS%

:end
pause