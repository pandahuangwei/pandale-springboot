@echo off 
rem ENABLEDELAYEDEXPANSION
rem ---------------------------------------------------------------------------
rem 
rem  @author panda.
rem  @since 2019-03-27 23:51.
rem 
rem ---------------------------------------------------------------------------

title build-ecding package

echo if build can not work ,please set JAVA_HOME and  MAVEN_HOME...

rem ---------------------------------------------------------------------------
rem set  JAVA_HOME and  MAVEN_HOME like this ,eg:
rem
rem set JAVA_HOME=D:\Program Files\jdk1.8.0_172
rem set MAVEN_HOME=E:\apache-maven-3.3.9
rem set CLASSPATH=.;%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\tools.jar
rem set Path=%JAVA_HOME%\bin;%JAVA_HOME%\jar\bin;%MAVEN_HOME%\bin
rem
rem ---------------------------------------------------------------------------


rem set JAVA_HOME=D:\Program Files\jdk1.8.0_172
rem set MAVEN_HOME=E:\apache-maven-3.3.9



if not "%JAVA_HOME%" == "" goto javaHomeEnd
echo please set JAVA_HOME...
goto end
:javaHomeEnd
echo Using JAVA_HOME:   "%JAVA_HOME%"


if not "%MAVEN_HOME%" == "" goto mavenHomeEnd
echo please set MAVEN_HOME...
goto end
:mavenHomeEnd
echo Using MAVEN_HOME:   "%MAVEN_HOME%"


if not "%PATH%" == "" goto pathEnd
echo please set MAVEN_HOME...
set PATH=%JAVA_HOME%\bin;%JAVA_HOME%\jar\bin;%MAVEN_HOME%\bin;C:\Windows\System32
goto end
:pathEnd
echo Using PATH:   "%PATH%"

set CLASSPATH=.;%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\tools.jar
rem set PATH=%JAVA_HOME%\bin;%JAVA_HOME%\jar\bin;%MAVEN_HOME%\bin

echo Using CLASSPATH:   "%CLASSPATH%"

echo= 
echo, 
echo;
echo ===  This build environment is OK. Let's go. ===
echo= 
echo, 
echo;

color 02

echo === Start building pandale... ===

cd ..\

rem call mvn clean install ʹ����������滻
rem  call mvn package -Dmaven.test.skip=true 

echo === End build pandale...=== 
echo= 
echo, 
echo;

rem ---------------------------------------------------------------------------
rem  Copy  file 
rem  echo ��ǰ�̷���%~d0
rem  echo ��ǰ�̷���·����%~dp0
rem  echo ��ǰ�̷���·���Ķ��ļ�����ʽ��%~sdp0
rem  echo ��ǰ������ȫ·����%~f0
rem  echo ��ǰCMDĬ��Ŀ¼��%cd%
rem ---------------------------------------------------------------------------

echo === Start copy file to targer ...=== 

cd %~dp0 

rem ��ʼ�����ļ�Ŀ¼����
echo del Last build jar, and Copy jar ...
set rootFloder=%~dp0pandale\
echo %rootFloder%


del/s /Q %~dp0pandale\
rd /S /Q %~dp0pandale\


rem �ӳ�2�룬ȷ����һ�����ִ�������������
ping -n 2 127.1 >nul

rem ������Ŀ¼
md "%~dp0pandale"
rem ������Ŀ¼�µ�WEBĿ¼
ping -n 1 127.1 >nul
md "%~dp0pandale\web"

rem ������Ŀ¼�µ�SERVERĿ¼
ping -n 1 127.1 >nul
md "%~dp0pandale\server"

cd %~dp0

rem �������ļ��ж�ȡ������Ϣ-jar�����б�
for /f "delims== tokens=1,*" %%a in ('type pandale-build.properties ^|findstr /i "ecding.server"') do  set modules="%%b"
rem �������ļ��ж�ȡ������Ϣ-webӦ���б�
for /f "delims== tokens=1,*" %%a in ('type pandale-build.properties ^|findstr /i "ecding.web"') do  set modulesweb="%%b"

rem ������ģ�飬�����ڹ��������ļ���(pandale-build.properties)
echo copy modules:  %modules%

cd ../
set suffix=
rem set suffix=-assembly

rem ���ñ����ӳ�
SETLOCAL ENABLEDELAYEDEXPANSION

:GOON
for /f "delims=, tokens=1,*" %%i in (%modules%) do (

	   echo %%i
	   set folderName=%%i%suffix%

	   XCOPY "%cd%\%%i\target\!folderName!\*"  "%~dp0pandale\server" /S /E /D
	   
	   
	   copy "%cd%\%%i\target\%%i.jar" %~dp0pandale\server\%%i\
	   ping -n 1 127.1 >nul
       set modules="%%j"	  
	   
     goto GOON
)

rem ����war��webĿ¼
rem copy  %cd%\bear-system-admin\target\*.war  %~dp0bears\web\
   
  
echo Build succeed,Press Space Key to Exit...
:end
pause