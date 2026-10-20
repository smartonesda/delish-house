Add-Type -AssemblyName System.Drawing

$src = "d:\LOMBA-KELAS-X\delish-house\assets\template-design\new\Jelajahi Kuliner Lokal Delish House.png"
$bmp = [System.Drawing.Bitmap]::FromFile($src)

# Let's crop from Y=800 to 1400 to see row 2 and 3
$cropRect = [System.Drawing.Rectangle]::new(0, 850, $bmp.Width, 550)
$target = [System.Drawing.Bitmap]::new($cropRect.Width, $cropRect.Height)
$g = [System.Drawing.Graphics]::FromImage($target)
$g.DrawImage($bmp, [System.Drawing.Rectangle]::new(0, 0, $cropRect.Width, $cropRect.Height), $cropRect, [System.Drawing.GraphicsUnit]::Pixel)
$g.Dispose()

$target.Save("d:\LOMBA-KELAS-X\delish-house\scratch\jelajahi_row2_3.png", [System.Drawing.Imaging.ImageFormat]::Png)
$target.Dispose()
$bmp.Dispose()
Write-Host "Saved jelajahi_row2_3.png"
