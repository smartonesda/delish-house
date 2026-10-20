Add-Type -AssemblyName System.Drawing

$srcPath = "d:\LOMBA-KELAS-X\delish-house\assets\template-design\new\Delish House_ Temukan Kuliner Lokal-2.png"
$src = [System.Drawing.Bitmap]::FromFile($srcPath)

# In the features section:
# Y ~ 380 to 500
# Let's crop each icon individually:
# Icon 1 (Cari): X ~ 70 to 140, Y ~ 395 to 455
# Icon 2 (Lokasi): X ~ 250 to 320, Y ~ 395 to 455
# Icon 3 (Hubungi): X ~ 440 to 510, Y ~ 395 to 455
# Icon 4 (AI): X ~ 625 to 695, Y ~ 395 to 455

$rect1 = New-Object System.Drawing.Rectangle(70, 395, 65, 65)
$src.Clone($rect1, $src.PixelFormat).Save("d:\LOMBA-KELAS-X\delish-house\scratch\icon_feature_1.png")

$rect2 = New-Object System.Drawing.Rectangle(250, 395, 65, 65)
$src.Clone($rect2, $src.PixelFormat).Save("d:\LOMBA-KELAS-X\delish-house\scratch\icon_feature_2.png")

$rect3 = New-Object System.Drawing.Rectangle(440, 395, 65, 65)
$src.Clone($rect3, $src.PixelFormat).Save("d:\LOMBA-KELAS-X\delish-house\scratch\icon_feature_3.png")

$rect4 = New-Object System.Drawing.Rectangle(625, 395, 65, 65)
$src.Clone($rect4, $src.PixelFormat).Save("d:\LOMBA-KELAS-X\delish-house\scratch\icon_feature_4.png")

$src.Dispose()
Write-Output "Feature icons cropped"
