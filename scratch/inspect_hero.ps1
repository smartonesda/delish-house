Add-Type -AssemblyName System.Drawing

$srcPath = "d:\LOMBA-KELAS-X\delish-house\assets\template-design\new\Delish House_ Temukan Kuliner Lokal-2.png"
$src = [System.Drawing.Bitmap]::FromFile($srcPath)

# Let's crop from Y=35 to Y=375, X=300 to 770
$rect = New-Object System.Drawing.Rectangle(320, 35, 450, 335)
$crop = $src.Clone($rect, $src.PixelFormat)
$crop.Save("d:\LOMBA-KELAS-X\delish-house\scratch\hero_right_full.png", [System.Drawing.Imaging.ImageFormat]::Png)
$crop.Dispose()

# Let's also crop the entire hero section across full width:
$rectFull = New-Object System.Drawing.Rectangle(0, 35, 786, 335)
$cropFull = $src.Clone($rectFull, $src.PixelFormat)
$cropFull.Save("d:\LOMBA-KELAS-X\delish-house\scratch\hero_full_section.png", [System.Drawing.Imaging.ImageFormat]::Png)
$cropFull.Dispose()

$src.Dispose()
Write-Output "Full hero cropped"
