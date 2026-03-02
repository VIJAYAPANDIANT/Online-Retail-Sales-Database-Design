@echo off
echo ==========================================
echo Online Retail Database Setup (Unified)
echo ==========================================

set MYSQL_PATH="C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe"

:: Check if MySQL exists
if not exist %MYSQL_PATH% (
    echo [ERROR] MySQL not found at %MYSQL_PATH%
    pause
    exit /b
)

set USER=root
set PASSWORD=Vijayt@2007

echo Running full setup script...
:: Using -t to display table output nicely
%MYSQL_PATH% -u %USER% -p%PASSWORD% -t < full_setup.sql

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [ERROR] The script encountered an error.
    echo Please check the output above.
) else (
    echo.
    echo ==========================================
    echo SUCCESS! Database created and queries run.
    echo ==========================================
)

pause
