Add-Type -AssemblyName System.Drawing

$srcPath = "d:\LOMBA-KELAS-X\delish-house\assets\template-design\new\Delish House_ Temukan Kuliner Lokal-2.png"
$src = [System.Drawing.Bitmap]::FromFile($srcPath)

Write-Output "Image size: $($src.Width) x $($src.Height)"

# Let's inspect where Cara Kerja is.
# In a typical ~1440x... image:
# Let's crop a sample around Y ~ 1400 to 2200
$cropRect = New-Object System.Drawing.Rectangle(0, [int]($src.Height * 0.4), $src.Width, [int]($src.Height * 0.25))
$sample = $src.Clone($cropRect, $src.PixelFormat)
$sample.Save("d:\LOMBA-KELAS-X\delish-house\scratch\sample_cara_kerja_area.png")

$sample.Dispose()
$src.Dispose()
Write-Output "Sample saved"
