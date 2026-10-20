Add-Type -AssemblyName System.Drawing

$srcPath = "d:\LOMBA-KELAS-X\delish-house\assets\template-design\new\Delish House_ Temukan Kuliner Lokal-2.png"
$src = [System.Drawing.Bitmap]::FromFile($srcPath)

# In sample_cara_kerja_area, Y offset was [int]($src.Height * 0.4) = 800.
# The icons are in the upper part of this area:
# In the master image, Y is roughly 850 to 1050.
# Let's crop a strip around the icons and steps: Y from 830 to 1080, full width.

$rect = New-Object System.Drawing.Rectangle(0, 830, $src.Width, 260)
$strip = $src.Clone($rect, $src.PixelFormat)
$strip.Save("d:\LOMBA-KELAS-X\delish-house\scratch\icons_strip.png")

$strip.Dispose()
$src.Dispose()
Write-Output "Strip saved"
