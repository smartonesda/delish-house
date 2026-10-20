Add-Type -AssemblyName System.Drawing

$src = "d:\LOMBA-KELAS-X\delish-house\scratch\category_section_sample.png"
$bmp = [System.Drawing.Bitmap]::FromFile($src)

$foodDir = "d:\LOMBA-KELAS-X\delish-house\assets\food"

function CropCardImg($x, $y, $w, $h, $name) {
    $rect = [System.Drawing.Rectangle]::new($x, $y, $w, $h)
    $target = [System.Drawing.Bitmap]::new($w, $h)
    $g = [System.Drawing.Graphics]::FromImage($target)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.DrawImage($bmp, [System.Drawing.Rectangle]::new(0, 0, $w, $h), $rect, [System.Drawing.GraphicsUnit]::Pixel)
    $g.Dispose()
    $outPath = Join-Path $foodDir "$name.png"
    $target.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $target.Dispose()
    Write-Host "Saved $name to $outPath"
}

# The image is rounded at the top inside the card
CropCardImg 286 117 149 88 "card_ayam_geprek"
CropCardImg 450 117 149 88 "card_kopi_susu"
CropCardImg 614 117 149 88 "card_mie_ayam"

$bmp.Dispose()
