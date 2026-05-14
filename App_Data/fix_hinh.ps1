Add-Type -AssemblyName System.Data

$mdfPath = (Resolve-Path ".\QuanLyNhaHang.mdf").Path
$connStr = "Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=$mdfPath;Integrated Security=True;Connect Timeout=30"

$conn = New-Object System.Data.SqlClient.SqlConnection($connStr)
$conn.Open()
Write-Host "Connected OK"

function UpdateHinh($tenMon, $hinhMoi) {
    $cmd = $conn.CreateCommand()
    $cmd.CommandText = "UPDATE MONAN SET HinhAnh = @hinh WHERE TenMon = @ten"
    [void]$cmd.Parameters.Add((New-Object System.Data.SqlClient.SqlParameter("@hinh", [System.Data.SqlDbType]::NVarChar, 300)))
    [void]$cmd.Parameters.Add((New-Object System.Data.SqlClient.SqlParameter("@ten", [System.Data.SqlDbType]::NVarChar, 200)))
    $cmd.Parameters["@hinh"].Value = $hinhMoi
    $cmd.Parameters["@ten"].Value = $tenMon
    $rows = $cmd.ExecuteNonQuery()
    Write-Host "Updated $tenMon -> $hinhMoi ($rows rows)"
}

UpdateHinh ("Ch" + [char]0x1EA3 + " gi" + [char]0xF2) "chagio.jpg"
UpdateHinh ("Soup b" + [char]0xE0 + "o ng" + [char]0x01B0) "suopbaongu.jpg"
UpdateHinh ("Ch" + [char]0xE8 + " " + [char]0x111 + [char]0x1EAD + "u xanh") "chedauxanh.jpg"
UpdateHinh ("B" + [char]0xFA + "n b" + [char]0xF2 + " Hu" + [char]0x1EBF) "bunbohue.jpg"

$conn.Close()
Write-Host "=== DONE ==="
