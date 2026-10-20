Add-Type -AssemblyName System.Drawing

$srcPath = "d:\LOMBA-KELAS-X\delish-house\assets\template-design\new\Delish House_ Temukan Kuliner Lokal-2.png"
$src = [System.Drawing.Bitmap]::FromFile($srcPath)

# Total size: 786 x 2001
# Cara kerja / Kelola usaha ended around Y ~ 1240.
# Peta Kuliner is around Y ~ 1240 to 1540
# Testimoni is around Y ~ 1520 to 1750
# CTA Banner is around Y ~ 1720 to 1880
# Footer is around Y ~ 1850 to 2001

$rectPeta = New-Object System.Drawing.Rectangle(0, 1220, $src.Width, 340)
$src.Clone($rectPeta, $src.PixelFormat).Save("d:\LOMBA-KELAS-X\delish-house\scratch\section_peta.png")

$rectTesti = New-Object System.Drawing.Rectangle(0, 1500, $src.Width, 260)
$src.Clone($rectTesti, $src.PixelFormat).Save("d:\LOMBA-KELAS-X\delish-house\scratch\section_testimoni.png")

$rectCta = New-Object System.Drawing.Rectangle(0, 1720, $src.Width, 280)
$src.Clone($rectCta, $src.PixelFormat).Save("d:\LOMBA-KELAS-X\delish-house\scratch\section_cta_footer.png")

$src.Dispose()
Write-Output "Sections cropped"
