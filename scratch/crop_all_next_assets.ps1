Add-Type -AssemblyName System.Drawing

$src = [System.Drawing.Bitmap]::FromFile("d:\LOMBA-KELAS-X\delish-house\assets\template-design\new\Delish House_ Temukan Kuliner Lokal-2.png")

# 1. Map Visual
# In section_peta, top of map is Y ~ 1240, bottom of card is Y ~ 1495, right edge is ~760, left pin is ~320
$rectMap = New-Object System.Drawing.Rectangle(320, 1238, 445, 260)
$cropMap = $src.Clone($rectMap, $src.PixelFormat)
$cropMap.Save("d:\LOMBA-KELAS-X\delish-house\scratch\peta_map_clean.png")
$cropMap.Dispose()

# 2. Testimonial Avatars:
# In section_testimoni (Y ~ 1500 to 1750)
# Card 1 (Siti): avatar circle around X ~ 42, Y ~ 1595, size ~ 48x48
$rectSiti = New-Object System.Drawing.Rectangle(42, 1590, 50, 50)
$cropSiti = $src.Clone($rectSiti, $src.PixelFormat)
$cropSiti.Save("d:\LOMBA-KELAS-X\delish-house\scratch\avatar_siti.png")
$cropSiti.Dispose()

# Card 2 (Fahri): avatar circle around X ~ 296, Y ~ 1590, size ~ 48x48
$rectFahri = New-Object System.Drawing.Rectangle(296, 1590, 50, 50)
$cropFahri = $src.Clone($rectFahri, $src.PixelFormat)
$cropFahri.Save("d:\LOMBA-KELAS-X\delish-house\scratch\avatar_fahri.png")
$cropFahri.Dispose()

# Card 3 (Dewi): avatar circle around X ~ 546, Y ~ 1590, size ~ 48x48
$rectDewi = New-Object System.Drawing.Rectangle(546, 1590, 50, 50)
$cropDewi = $src.Clone($rectDewi, $src.PixelFormat)
$cropDewi.Save("d:\LOMBA-KELAS-X\delish-house\scratch\avatar_dewi.png")
$cropDewi.Dispose()

# 3. CTA Bowl Graphic:
# In section_cta_footer, banner is Y ~ 1740 to 1840.
# Left food bowl is X ~ 20 to 220, Y ~ 1735 to 1845
$rectBowl = New-Object System.Drawing.Rectangle(20, 1735, 205, 110)
$cropBowl = $src.Clone($rectBowl, $src.PixelFormat)
$cropBowl.Save("d:\LOMBA-KELAS-X\delish-house\scratch\cta_bowl.png")
$cropBowl.Dispose()

$src.Dispose()
Write-Output "Assets cropped successfully"
