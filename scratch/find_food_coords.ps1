Add-Type -AssemblyName System.Drawing

$src = "d:\LOMBA-KELAS-X\delish-house\assets\template-design\new\Delish House_ Temukan Kuliner Lokal-2.png"
$bmp = [System.Drawing.Bitmap]::FromFile($src)

$cropRect = [System.Drawing.Rectangle]::new(0, 520, $bmp.Width, 300)
$target = [System.Drawing.Bitmap]::new($cropRect.Width, $cropRect.Height)
$g = [System.Drawing.Graphics]::FromImage($target)
$g.DrawImage($bmp, [System.Drawing.Rectangle]::new(0, 0, $cropRect.Width, $cropRect.Height), $cropRect, [System.Drawing.GraphicsUnit]::Pixel)
$g.Dispose()

$target.Save("d:\LOMBA-KELAS-X\delish-house\scratch\category_section_sample.png", [System.Drawing.Imaging.ImageFormat]::Png)
$target.Dispose()
$bmp.Dispose()
Write-Host "Saved category_section_sample.png"
