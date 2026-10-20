Add-Type -AssemblyName System.Drawing

$src = [System.Drawing.Bitmap]::FromFile("d:\LOMBA-KELAS-X\delish-house\assets\template-design\new\Delish House_ Temukan Kuliner Lokal-2.png")

# 1. Peta Visual (from Y=1246 to 1445, X=318 to 765):
# Let's crop clean map visual:
$rectMap = New-Object System.Drawing.Rectangle(318, 1246, 448, 196)
$cropMap = $src.Clone($rectMap, $src.PixelFormat)
$cropMap.Save("d:\LOMBA-KELAS-X\delish-house\assets\new\peta-visual.png")
$cropMap.Dispose()

# 2. Testimonial Avatars (centered on face):
$rectSiti = New-Object System.Drawing.Rectangle(50, 1520, 48, 48)
$cropSiti = $src.Clone($rectSiti, $src.PixelFormat)
$cropSiti.Save("d:\LOMBA-KELAS-X\delish-house\assets\new\avatar-siti.png")
$cropSiti.Dispose()

$rectFahri = New-Object System.Drawing.Rectangle(306, 1520, 48, 48)
$cropFahri = $src.Clone($rectFahri, $src.PixelFormat)
$cropFahri.Save("d:\LOMBA-KELAS-X\delish-house\assets\new\avatar-fahri.png")
$cropFahri.Dispose()

$rectDewi = New-Object System.Drawing.Rectangle(554, 1520, 48, 48)
$cropDewi = $src.Clone($rectDewi, $src.PixelFormat)
$cropDewi.Save("d:\LOMBA-KELAS-X\delish-house\assets\new\avatar-dewi.png")
$cropDewi.Dispose()

# 3. Whole CTA Banner (X=16, Y=1652, Width=754, Height=98):
$rectCtaFull = New-Object System.Drawing.Rectangle(18, 1652, 750, 96)
$cropCtaFull = $src.Clone($rectCtaFull, $src.PixelFormat)
$cropCtaFull.Save("d:\LOMBA-KELAS-X\delish-house\assets\new\cta-banner-full.png")
$cropCtaFull.Dispose()

$src.Dispose()
Write-Output "Perfect assets saved"
