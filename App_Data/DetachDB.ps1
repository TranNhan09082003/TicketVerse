$conn = New-Object System.Data.SqlClient.SqlConnection("Server=(LocalDB)\MSSQLLocalDB;Integrated Security=True")
$conn.Open()
$cmd = $conn.CreateCommand()
$cmd.CommandText = "ALTER DATABASE [TicketVerse] SET SINGLE_USER WITH ROLLBACK IMMEDIATE; EXEC sp_detach_db 'TicketVerse', 'true'"
$cmd.ExecuteNonQuery() | Out-Null
$conn.Close()
Write-Host "Detached OK!" -ForegroundColor Green
