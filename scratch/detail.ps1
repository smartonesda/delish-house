Add-Type -AssemblyName System.Drawing

$srcPath = "d:\LOMBA-KELAS-X\delish-house\assets\template-design\new\Delish House_ Temukan Kuliner Lokal-2.png"
$src = [System.Drawing.Bitmap]::FromFile($srcPath)

# Let's crop the visual area with high precision:
# Let's check where the vendor starts:
# The torn paper note is at X ~ 360 to 450, Y ~ 70 to 230
# The search button is at X ~ 375 to 408, Y ~ 254 to 287
# The white speech bubble "UMKM Berkembang Bersama Teknologi! ❤️" is at X ~ 448 to 555, Y ~ 265 to 345
# So the search button is in the gap between the torn paper note, the vendor's body/counter, and the bottom speech bubble!

$rect = New-Object System.Drawing.Rectangle(340, 35, 430, 335)
$crop = $src.Clone($rect, $src.PixelFormat)
$crop.Save("d:\LOMBA-KELAS-X\delish-house\scratch\hero_illustration_detail.png", [System.Drawing.Imaging.ImageFormat]::Png)
$crop.Dispose()
$src.Dispose()
Write-Output "Detail saved"
