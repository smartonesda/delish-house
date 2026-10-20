Add-Type -AssemblyName System.Drawing

$src = "d:\LOMBA-KELAS-X\delish-house\scratch\category_section_sample.png"
$bmp = [System.Drawing.Bitmap]::FromFile($src)

# Let's inspect where the 3 food images are located in category_section_sample.png
# Card 1: Ayam Geprek Sambal Matah
# Card 2: Es Kopi Susu Gula Aren
# Card 3: Mie Ayam Bakso Spesial

# In the 786-width image:
# Card 1 image is roughly X: 285 to 435, Y: 115 to 215
# Card 2 image is roughly X: 450 to 600, Y: 115 to 215
# Card 3 image is roughly X: 615 to 765, Y: 115 to 215

Write-Host "Sample Width: $($bmp.Width), Height: $($bmp.Height)"

# Create assets/food if not exists
$foodDir = "d:\LOMBA-KELAS-X\delish-house\assets\food"
if (!(Test-Path $foodDir)) {
    New-Item -ItemType Directory -Path $foodDir -Force | Out-Null
}

function CropFood($x, $y, $w, $h, $name) {
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

# Test crops
CropFood 286 117 149 97 "ayam_geprek"
CropFood 450 117 149 97 "kopi_susu"
CropFood 614 117 149 97 "mie_ayam"

$bmp.Dispose()
