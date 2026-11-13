
@echo off
set "JAVA_HOME="
set "MAVEN_HOME=C:\Custom_soft\apache-maven-3.9.6"

if "%~1"=="17" set "JAVA_HOME=C:\Program Files\Java\jdk-17"
if "%~1"=="21" set "JAVA_HOME=C:\Program Files\Java\jdk-21.0.2"
if "%~1"=="25" set "JAVA_HOME=C:\Program Files\Java\jdk-25.0.2"

if not defined JAVA_HOME (
    echo Invalid Java version.
    echo Usage: java-switch 17 or 21 or 25
    exit /b 1
)

if not exist "%JAVA_HOME%\bin\java.exe" (
    echo ERROR: JDK not found: %JAVA_HOME%
    exit /b 1
)

if not exist "%MAVEN_HOME%\bin\mvn.cmd" (
    echo ERROR: Maven not found: %MAVEN_HOME%
    exit /b 1
)

REM Update Java and Maven for the current CMD session
set "PATH=%JAVA_HOME%\bin;%MAVEN_HOME%\bin;%PATH%"

echo.
echo Java switched successfully!
echo JAVA_HOME=%JAVA_HOME%
echo MAVEN_HOME=%MAVEN_HOME%

echo.
echo Java executable:
where java

echo.
echo Java version:
java -version

echo.
echo Maven version:
call "%MAVEN_HOME%\bin\mvn.cmd" -version

exit /b 0
