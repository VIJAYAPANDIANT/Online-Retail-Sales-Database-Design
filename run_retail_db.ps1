# PowerShell script to run Online Retail Database scripts
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  Online Retail Database Setup & Test" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

# 1. Try to find MySQL executable
$mysqlPath = "mysql" # Default to PATH
$possiblePaths = @(
    "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe",
    "C:\Program Files\MySQL\MySQL Server 8.4\bin\mysql.exe",
    "C:\Program Files (x86)\MySQL\MySQL Server 8.0\bin\mysql.exe"
)

foreach ($path in $possiblePaths) {
    if (Test-Path $path) {
        $mysqlPath = "& '$path'"
        Write-Host "Found MySQL at: $path" -ForegroundColor Green
        break
    }
}

# 2. Set Credentials
$user = "root"
$password = "Vijayt@2007" # Hardcoded as provided by user

# Build arguments
$mysqlArgs = "-u $user -p$password"

Write-Host "`n[1/3] Creating Schema..." -ForegroundColor Yellow
Invoke-Expression "Get-Content .\schema.sql | $mysqlPath $mysqlArgs"

Write-Host "`n[2/3] Populating Data..." -ForegroundColor Yellow
Invoke-Expression "Get-Content .\data.sql | $mysqlPath $mysqlArgs"

Write-Host "`n[3/3] Running Analytical Queries..." -ForegroundColor Yellow
# Run queries and capture output
$cmd = "Get-Content .\queries.sql | $mysqlPath $mysqlArgs -t"
Invoke-Expression $cmd

Write-Host "`n==========================================" -ForegroundColor Cyan
Write-Host "  Done! Check the results above." -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Pause
