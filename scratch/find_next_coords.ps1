Add-Type -AssemblyName System.Drawing

$src = [System.Drawing.Bitmap]::FromFile("d:\LOMBA-KELAS-X\delish-house\assets\template-design\new\Delish House_ Temukan Kuliner Lokal-2.png")

# 1. Peta Visual:
# Let's crop from Y=1250 to 1485 (height 235), X=320 to 765 (width 445)
$rectMap = New-Object System.Drawing.Rectangle(320, 1250, 445, 235)
$cropMap = $src.Clone($rectMap, $src.PixelFormat)
$cropMap.Save("d:\LOMBA-KELAS-X\delish-house\assets\new\peta-visual.png")
$cropMap.Dispose()

# 2. Testimonial Section strip:
# Let's crop Y from 1550 to 1750 to locate cards and avatars precisely
$rectTestiCards = New-Object System.Drawing.Rectangle(0, 1560, $src.Width, 180)
$cropCards = $src.Clone($rectTestiCards, $src.PixelFormat)
$cropCards.Save("d:\LOMBA-KELAS-X\delish-house\scratch\testi_cards_strip.png")
$cropCards.Dispose()

# 3. CTA Banner strip:
$rectCtaBanner = New-Object System.Drawing.Rectangle(15, 1750, 756, 115)
$cropCta = $src.Clone($rectCtaBanner, $src.PixelFormat)
$cropCta.Save("d:\LOMBA-KELAS-X\delish-house\scratch\cta_banner_strip.png")
$cropCta.Dispose()

$src.Dispose()
Write-Output "Strips saved"
