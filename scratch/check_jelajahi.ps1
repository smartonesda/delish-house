Add-Type -AssemblyName System.Drawing

$src = "d:\LOMBA-KELAS-X\delish-house\assets\template-design\new\Jelajahi Kuliner Lokal Delish House.png"
$bmp = [System.Drawing.Bitmap]::FromFile($src)
Write-Host "Jelajahi Width: $($bmp.Width), Height: $($bmp.Height)"

# In Jelajahi, the cards are around Y = 500 to 1400
# Let's crop a section of the cards grid to see the exact positions
$cropRect = [System.Drawing.Rectangle]::new(0, 500, $bmp.Width, 500)
$target = [System.Drawing.Bitmap]::new($cropRect.Width, $cropRect.Height)
$g = [System.Drawing.Graphics]::FromImage($target)
$g.DrawImage($bmp, [System.Drawing.Rectangle]::new(0, 0, $cropRect.Width, $cropRect.Height), $cropRect, [System.Drawing.GraphicsUnit]::Pixel)
$g.Dispose()

$target.Save("d:\LOMBA-KELAS-X\delish-house\scratch\jelajahi_cards_sample.png", [System.Drawing.Imaging.ImageFormat]::Png)
$target.Dispose()
$bmp.Dispose()
Write-Host "Saved jelajahi_cards_sample.png"
