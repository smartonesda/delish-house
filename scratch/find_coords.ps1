Add-Type -AssemblyName System.Drawing

$srcPath = "d:\LOMBA-KELAS-X\delish-house\assets\template-design\new\Delish House_ Temukan Kuliner Lokal-2.png"
$src = [System.Drawing.Bitmap]::FromFile($srcPath)

# Let's crop hero illustration on the right side:
# Left side of hero has text, search bar, etc.
# Right side of hero has the vendor illustration with the torn note, badge, and food card.
# In a 786px wide image, let's look at the range X: 350 to 760, Y: 40 to 360.

$rect = New-Object System.Drawing.Rectangle(340, 40, 430, 320)
$crop = $src.Clone($rect, $src.PixelFormat)
$crop.Save("d:\LOMBA-KELAS-X\delish-house\scratch\hero_illustration_crop1.png", [System.Drawing.Imaging.ImageFormat]::Png)
$crop.Dispose()

# Let's also crop the 4 feature cards section:
$rect2 = New-Object System.Drawing.Rectangle(20, 350, 746, 150)
$crop2 = $src.Clone($rect2, $src.PixelFormat)
$crop2.Save("d:\LOMBA-KELAS-X\delish-house\scratch\features_crop1.png", [System.Drawing.Imaging.ImageFormat]::Png)
$crop2.Dispose()

# Let's also crop the navbar:
$rect3 = New-Object System.Drawing.Rectangle(20, 0, 746, 55)
$crop3 = $src.Clone($rect3, $src.PixelFormat)
$crop3.Save("d:\LOMBA-KELAS-X\delish-house\scratch\navbar_crop1.png", [System.Drawing.Imaging.ImageFormat]::Png)
$crop3.Dispose()

$src.Dispose()
Write-Output "Crops created successfully"
