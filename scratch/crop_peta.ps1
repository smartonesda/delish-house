Add-Type -AssemblyName System.Drawing

$src = [System.Drawing.Bitmap]::FromFile("d:\LOMBA-KELAS-X\delish-house\assets\template-design\new\Delish House_ Temukan Kuliner Lokal-2.png")

# In Delish House_ Temukan Kuliner Lokal-2.png:
# Map visual is on the right side of Peta Kuliner section:
# X roughly from 300 to 760, Y roughly from 1240 to 1520
$mapRect = New-Object System.Drawing.Rectangle(320, 1240, 440, 260)
$mapCrop = $src.Clone($mapRect, $src.PixelFormat)
$mapCrop.Save("d:\LOMBA-KELAS-X\delish-house\scratch\peta_visual_crop.png")

$mapCrop.Dispose()
$src.Dispose()
Write-Output "Map visual cropped"
