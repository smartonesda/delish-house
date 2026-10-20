Add-Type -AssemblyName System.Drawing

$src = [System.Drawing.Bitmap]::FromFile("d:\LOMBA-KELAS-X\delish-house\assets\template-design\new\Delish House_ Temukan Kuliner Lokal-2.png")

# 1. Peta Visual (from Y=1240 to Y=1455, X=315 to 765):
$rectMap = New-Object System.Drawing.Rectangle(315, 1240, 450, 215)
$cropMap = $src.Clone($rectMap, $src.PixelFormat)
$cropMap.Save("d:\LOMBA-KELAS-X\delish-house\assets\new\peta-visual.png")
$cropMap.Dispose()

# 2. Testimonial Avatars:
# Card 1 (Siti): circle is X ~ 54, Y ~ 1525, size ~ 46x46
$rectSiti = New-Object System.Drawing.Rectangle(52, 1520, 50, 50)
$cropSiti = $src.Clone($rectSiti, $src.PixelFormat)
$cropSiti.Save("d:\LOMBA-KELAS-X\delish-house\assets\new\avatar-siti.png")
$cropSiti.Dispose()

# Card 2 (Fahri): circle is X ~ 308, Y ~ 1525, size ~ 46x46
$rectFahri = New-Object System.Drawing.Rectangle(306, 1520, 50, 50)
$cropFahri = $src.Clone($rectFahri, $src.PixelFormat)
$cropFahri.Save("d:\LOMBA-KELAS-X\delish-house\assets\new\avatar-fahri.png")
$cropFahri.Dispose()

# Card 3 (Dewi): circle is X ~ 556, Y ~ 1525, size ~ 46x46
$rectDewi = New-Object System.Drawing.Rectangle(554, 1520, 50, 50)
$cropDewi = $src.Clone($rectDewi, $src.PixelFormat)
$cropDewi.Save("d:\LOMBA-KELAS-X\delish-house\assets\new\avatar-dewi.png")
$cropDewi.Dispose()

# 3. CTA Bowl Graphic (X ~ 16, Y ~ 1650, width ~ 240, height ~ 100):
$rectCtaBowl = New-Object System.Drawing.Rectangle(18, 1650, 235, 100)
$cropBowl = $src.Clone($rectCtaBowl, $src.PixelFormat)
$cropBowl.Save("d:\LOMBA-KELAS-X\delish-house\assets\new\cta-bowl-graphic.png")
$cropBowl.Dispose()

$src.Dispose()
Write-Output "Extracted all assets successfully"
