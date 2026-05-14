Add-Type -AssemblyName System.Data

$mdfPath = (Resolve-Path ".\QuanLyNhaHang.mdf").Path
$connStr = "Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=$mdfPath;Integrated Security=True;Connect Timeout=30"

$conn = New-Object System.Data.SqlClient.SqlConnection($connStr)
$conn.Open()

$cmd = $conn.CreateCommand()
$cmd.CommandText = "SELECT TenMon, HinhAnh FROM MONAN"
$reader = $cmd.ExecuteReader()
while ($reader.Read()) {
    Write-Host ($reader["TenMon"].ToString() + " -> " + $reader["HinhAnh"].ToString())
}

$conn.Close()
