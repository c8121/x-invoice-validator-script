@echo off
setlocal enabledelayedexpansion

set "input_xml=%~1"
if "%input_xml%"=="" (
    echo USAGE: %~nx0 ^<xml-file^>
    exit /b 1
)

if not exist "%input_xml%" (
    echo USAGE: %~nx0 ^<xml-file^>
    exit /b 1
)

set "input_filename=%~dpn1"
for %%I in ("%input_filename%") do set "input_filename=%%~nxI"
set "output_dir=%TEMP%"
set "output_html=%output_dir%\%input_filename%-report.html"

echo %output_html%
exit

:: dirname $0
set "script_dir=%~dp0"
set "script_dir=%script_dir:~0,-1%"

set "kosit_jar="
for %%F in ("%script_dir%\validator-*-standalone.jar") do (
    set "kosit_jar=%%F"
)

set "config=%script_dir%\config"
set "scenarios=%config%\scenarios.xml"

echo JAR: %kosit_jar%
if "%kosit_jar%"=="" (
    echo ERROR: Validator not found in %script_dir%
    echo   Please visit https://github.com/itplr-kosit/validator/releases/ and download validator-x.x.x-standalone.jar
    echo   Place the downloaded jar-file in '%script_dir%'
    exit /b 1
)
if not exist "%kosit_jar%" (
    echo ERROR: Validator not found: %kosit_jar%
    echo   Please visit https://github.com/itplr-kosit/validator/releases/ and download validator-x.x.x-standalone.jar
    echo   Place the downloaded jar-file in '%script_dir%'
    exit /b 1
)

echo CONFIG: %config%
if not exist "%config%\" (
    echo ERROR: Validator config not found
    echo   Please visit https://github.com/itplr-kosit/validator-configuration-xrechnung/releases/ and download xrechnung-x.x.x-validator-configuration-x.zip
    echo   Unzip the downloaded zip-file into '%config%'
    exit /b 1
)

echo SCENARIOS: %scenarios%
if not exist "%scenarios%" (
    echo ERROR: Scenarios XML not found
    echo   The Scenarios XML be at '%scenarios' and is part of xrechnung-x.x.x-validator-configuration-x.zip
    exit /b 1
)

java ^
    -jar "%kosit_jar%" ^
    -r "%config%" ^
    -s "%scenarios%" ^
    -o "%output_dir%" ^
    -h ^
    "%input_xml%"

echo Validation finished. Report can be found at %output_html%

endlocal
