Add-Type -AssemblyName System.Drawing

$srcPath = "d:\LOMBA-KELAS-X\delish-house\assets\template-design\new\Delish House_ Temukan Kuliner Lokal-2.png"
$src = [System.Drawing.Bitmap]::FromFile($srcPath)

# Check Y=360 to 410, X=650 to 786 (where Tersedia badge and card bottom are)
$rect = New-Object System.Drawing.Rectangle(650, 350, 136, 60)
$crop = $src.Clone($rect, $src.PixelFormat)
$crop.Save("d:\LOMBA-KELAS-X\delish-house\scratch\tersedia_badge.png", [System.Drawing.Imaging.ImageFormat]::Png)
$crop.Dispose()
$src.Dispose()
Write-Output "Tersedia badge saved"
