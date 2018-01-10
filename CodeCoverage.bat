@ECHO OFF



SET DllContainingTests=%~dp0DevOpsDemo.Test\bin\Debug\DevOpsDemo.Test.dll


REM NUnit Test Runner (done this way so we dont have to change the code 
REM when the version number changes)
for /R "%~dp0packages" %%a in (*) do if /I "%%~nxa"=="nunit-console.exe" SET TestRunnerExe=%%~dpnxa

REM Get OpenCover Executable (done this way so we dont have to change the 
REM code when the version number changes)
for /R "%~dp0packages" %%a in (*) do if /I "%%~nxa"=="OpenCover.Console.exe" SET OpenCoverExe=%%~dpnxa

REM Get Report Generator (done this way so we dont have to change the code 
REM when the version number changes)
for /R "%~dp0packages" %%a in (*) do if /I "%%~nxa"=="ReportGenerator.exe" SET ReportGeneratorExe=%%~dpnxa

REM Create a 'GeneratedReports' folder if it does not exist
if not exist "%~dp0GeneratedReports" mkdir "%~dp0GeneratedReports"

REM Run the tests against the targeted output
call :RunOpenCoverUnitTestMetrics

REM Generate the report output based on the test results
if %errorlevel% equ 0 ( 
 call :RunReportGeneratorOutput 
)

REM Launch the report
if %errorlevel% equ 0 ( 
 call :RunLaunchReport 
)
exit /b %errorlevel%

:RunOpenCoverUnitTestMetrics 
REM *** Change the filter to include/exclude parts of the solution you want 
REM *** to check for test coverage
"%OpenCoverExe%" ^
 -target:"%TestRunnerExe%" ^
 -targetargs:"\"%DllContainingTests%\" --params Path=C:" ^
 -filter:"+[*]* -[*.Test*]* -[*]*.*Config" ^
 -mergebyhash ^
 -skipautoprops ^
 -register:user ^
 -output:"%~dp0GeneratedReports\CoverageReport.xml"
exit /b %errorlevel%

:RunReportGeneratorOutput
"%ReportGeneratorExe%" ^
 -reports:"%~dp0\GeneratedReports\CoverageReport.xml" ^
 -targetdir:"%~dp0\GeneratedReports\ReportGenerator Output"
exit /b %errorlevel%

:RunLaunchReport
start "report" "%~dp0\GeneratedReports\ReportGenerator Output\index.htm"
exit /b %errorlevel%