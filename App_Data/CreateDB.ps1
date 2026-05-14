<# TicketVerse Database Creator #>
$appDataPath = "c:\Users\ivano\Downloads\TranTrongNhan_3501\TranTrongNhan_3501\TranTrongNhan_35011\App_Data"
$mdfPath = "$appDataPath\TicketVerse.mdf"
$logPath = "$appDataPath\TicketVerse_log.ldf"

if (Test-Path $mdfPath) { Remove-Item $mdfPath -Force }
if (Test-Path $logPath) { Remove-Item $logPath -Force }

$connMaster = "Server=(LocalDB)\MSSQLLocalDB;Integrated Security=True"

# Create database
$conn = New-Object System.Data.SqlClient.SqlConnection($connMaster)
$conn.Open()
$cmd = $conn.CreateCommand()
$cmd.CommandText = "CREATE DATABASE [TicketVerse] ON PRIMARY (NAME=N'TicketVerse',FILENAME=N'$mdfPath',SIZE=8MB,FILEGROWTH=64MB) LOG ON (NAME=N'TicketVerse_log',FILENAME=N'$logPath',SIZE=8MB,FILEGROWTH=64MB)"
$cmd.ExecuteNonQuery() | Out-Null
$conn.Close()
Write-Host "DB created!" -ForegroundColor Green

# Read and execute SQL file
$sqlFile = "$appDataPath\TicketVerse_Schema.sql"
$connDb = "Server=(LocalDB)\MSSQLLocalDB;Database=TicketVerse;Integrated Security=True"
$conn2 = New-Object System.Data.SqlClient.SqlConnection($connDb)
$conn2.Open()

$sqlContent = [System.IO.File]::ReadAllText($sqlFile, [System.Text.Encoding]::UTF8)
$batches = $sqlContent -split "\r?\nGO\r?\n"

foreach ($batch in $batches) {
    $trimmed = $batch.Trim()
    if ($trimmed.Length -gt 0) {
        # Split by semicolons for individual statements
        $statements = $trimmed -split ";\r?\n"
        foreach ($stmt in $statements) {
            $s = $stmt.Trim()
            if ($s.Length -gt 5) {
                try {
                    $cmd2 = $conn2.CreateCommand()
                    $cmd2.CommandText = $s
                    $cmd2.ExecuteNonQuery() | Out-Null
                } catch {
                    Write-Host "WARN: $($_.Exception.Message)" -ForegroundColor Yellow
                }
            }
        }
    }
}

$conn2.Close()

# Detach
$conn3 = New-Object System.Data.SqlClient.SqlConnection($connMaster)
$conn3.Open()
$cmd3 = $conn3.CreateCommand()
$cmd3.CommandText = "EXEC sp_detach_db 'TicketVerse', 'true'"
$cmd3.ExecuteNonQuery() | Out-Null
$conn3.Close()

Write-Host "DONE! TicketVerse.mdf created at: $mdfPath" -ForegroundColor Green
