Add-Type -AssemblyName System.Drawing

$src = "d:\LOMBA-KELAS-X\delish-house\scratch\category_section_sample.png"
$bmp = [System.Drawing.Bitmap]::FromFile($src)
$foodDir = "d:\LOMBA-KELAS-X\delish-house\assets\food"

# Card 3 is at X=614, Y=117, W=149, H=79
$rect = [System.Drawing.Rectangle]::new(614, 117, 149, 79)
$target = [System.Drawing.Bitmap]::new(149, 79)
$g = [System.Drawing.Graphics]::FromImage($target)
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.DrawImage($bmp, [System.Drawing.Rectangle]::new(0, 0, 149, 79), $rect, [System.Drawing.GraphicsUnit]::Pixel)
$g.Dispose()

# Now let's see if we can overlay the right edge from mie_ayam.png from jelajahi
$srcMie = "d:\LOMBA-KELAS-X\delish-house\assets\food\mie_ayam.png"
if (Test-Path $srcMie) {
    $bmpMie = [System.Drawing.Bitmap]::FromFile($srcMie)
    # The right 35 pixels of $target has the white circle arrow.
    # In $bmpMie, it's 156x106. Let's take the right portion of bmpMie and blend/draw it over the white circle!
    $gTarget = [System.Drawing.Graphics]::FromImage($target)
    $srcRectMie = [System.Drawing.Rectangle]::new(120, 10, 36, 79)
    $destRect = [System.Drawing.Rectangle]::new(115, 0, 34, 79)
    $gTarget.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $gTarget.DrawImage($bmpMie, $destRect, $srcRectMie, [System.Drawing.GraphicsUnit]::Pixel)
    $gTarget.Dispose()
    $bmpMie.Dispose()
}

$outPath = Join-Path $foodDir "card_mie_ayam.png"
$target.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
$target.Dispose()
$bmp.Dispose()
Write-Host "Saved patched card_mie_ayam.png"
