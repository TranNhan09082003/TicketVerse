$projPath = "c:\Users\ivano\Downloads\TranTrongNhan_3501\TranTrongNhan_3501\TranTrongNhan_35011\TranTrongNhan_35011.csproj"
$baseDir = "c:\Users\ivano\Downloads\TranTrongNhan_3501\TranTrongNhan_3501\TranTrongNhan_35011"

[xml]$proj = Get-Content $projPath
$ns = New-Object System.Xml.XmlNamespaceManager($proj.NameTable)
$ns.AddNamespace("ns", "http://schemas.microsoft.com/developer/msbuild/2003")

$itemGroup = $proj.CreateElement("ItemGroup", "http://schemas.microsoft.com/developer/msbuild/2003")
$proj.DocumentElement.AppendChild($itemGroup) | Out-Null

$filesToAdd = @(
    "TicketVerse.master",
    "TicketVerse.master.cs",
    "TicketVerse.master.designer.cs",
    "TrangChu.aspx",
    "TrangChu.aspx.cs",
    "TrangChu.aspx.designer.cs",
    "DangNhap.aspx",
    "DangNhap.aspx.cs",
    "DangNhap.aspx.designer.cs",
    "DangKy.aspx",
    "DangKy.aspx.cs",
    "DangKy.aspx.designer.cs",
    "DanhSachSuKien.aspx",
    "DanhSachSuKien.aspx.cs",
    "DanhSachSuKien.aspx.designer.cs",
    "ChiTietSuKien.aspx",
    "ChiTietSuKien.aspx.cs",
    "ChiTietSuKien.aspx.designer.cs",
    "GioHang.aspx",
    "GioHang.aspx.cs",
    "GioHang.aspx.designer.cs",
    "ThanhToan.aspx",
    "ThanhToan.aspx.cs",
    "ThanhToan.aspx.designer.cs",
    "DonHang.aspx",
    "DonHang.aspx.cs",
    "DonHang.aspx.designer.cs",
    "TaiKhoan.aspx",
    "TaiKhoan.aspx.cs",
    "TaiKhoan.aspx.designer.cs",
    "Admin\AdminMaster.master",
    "Admin\AdminMaster.master.cs",
    "Admin\AdminMaster.master.designer.cs",
    "Admin\Dashboard.aspx",
    "Admin\Dashboard.aspx.cs",
    "Admin\Dashboard.aspx.designer.cs",
    "Admin\QuanLySuKien.aspx",
    "Admin\QuanLySuKien.aspx.cs",
    "Admin\QuanLySuKien.aspx.designer.cs",
    "Admin\QuanLyDonHang.aspx",
    "Admin\QuanLyDonHang.aspx.cs",
    "Admin\QuanLyDonHang.aspx.designer.cs",
    "Admin\QuanLyNguoiDung.aspx",
    "Admin\QuanLyNguoiDung.aspx.cs",
    "Admin\QuanLyNguoiDung.aspx.designer.cs",
    "Assets\css\ticketverse.css",
    "Assets\js\ticketverse.js",
    "Models\KetNoi.cs"
)

$added = 0
foreach ($file in $filesToAdd) {
    # Check if exists in XML
    $existing = $proj.SelectNodes("//ns:Compile[@Include='$file'] | //ns:Content[@Include='$file']", $ns)
    if ($existing.Count -eq 0) {
        $ext = [System.IO.Path]::GetExtension($file).ToLower()
        $nodeType = if ($ext -eq ".cs") { "Compile" } else { "Content" }
        
        $node = $proj.CreateElement($nodeType, "http://schemas.microsoft.com/developer/msbuild/2003")
        $node.SetAttribute("Include", $file)

        # Handle nesting for code-behind
        if ($file.EndsWith(".aspx.cs") -or $file.EndsWith(".master.cs")) {
            $parent = $file.Replace(".cs", "")
            $dep = $proj.CreateElement("DependentUpon", "http://schemas.microsoft.com/developer/msbuild/2003")
            $dep.InnerText = [System.IO.Path]::GetFileName($parent)
            $node.AppendChild($dep) | Out-Null
            $sub = $proj.CreateElement("SubType", "http://schemas.microsoft.com/developer/msbuild/2003")
            $sub.InnerText = "ASPXCodeBehind"
            $node.AppendChild($sub) | Out-Null
        }
        elseif ($file.EndsWith(".designer.cs")) {
            $parent = $file.Replace(".designer.cs", "")
            $dep = $proj.CreateElement("DependentUpon", "http://schemas.microsoft.com/developer/msbuild/2003")
            $dep.InnerText = [System.IO.Path]::GetFileName($parent)
            $node.AppendChild($dep) | Out-Null
        }

        $itemGroup.AppendChild($node) | Out-Null
        $added++
    }
}

$proj.Save($projPath)
Write-Host "Updated .csproj! Added $added files."
