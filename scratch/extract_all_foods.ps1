Add-Type -AssemblyName System.Drawing

$src = "d:\LOMBA-KELAS-X\delish-house\assets\template-design\new\Jelajahi Kuliner Lokal Delish House.png"
$bmp = [System.Drawing.Bitmap]::FromFile($src)

$foodDir = "d:\LOMBA-KELAS-X\delish-house\assets\food"
if (!(Test-Path $foodDir)) {
    New-Item -ItemType Directory -Path $foodDir -Force | Out-Null
}

function CropPure($x, $y, $w, $h, $name) {
    $rect = [System.Drawing.Rectangle]::new($x, $y, $w, $h)
    $target = [System.Drawing.Bitmap]::new($w, $h)
    $g = [System.Drawing.Graphics]::FromImage($target)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.DrawImage($bmp, [System.Drawing.Rectangle]::new(0, 0, $w, $h), $rect, [System.Drawing.GraphicsUnit]::Pixel)
    $g.Dispose()
    $outPath = Join-Path $foodDir "$name.webp"
    # Save as PNG first, or WebP if supported, otherwise PNG
    $pngPath = Join-Path $foodDir "$name.png"
    $target.Save($pngPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $target.Dispose()
    Write-Host "Saved $name to $pngPath"
}

# Row 1 (Y ~ 440 to 550)
CropPure 203 440 156 106 "nasi_goreng"
CropPure 373 440 156 106 "es_teh"
CropPure 540 440 156 106 "bakso_urat"

# Row 2 (Y ~ 730 to 838)
CropPure 203 730 156 106 "pisang_goreng"
CropPure 373 730 156 106 "mie_ayam"
CropPure 540 730 156 106 "sate_ayam"

# Row 3 (Y ~ 1022 to 1130)
CropPure 203 1022 156 106 "es_campur"
CropPure 373 1022 156 106 "seblak"
CropPure 540 1022 156 106 "ayam_geprek_jelajahi"

$bmp.Dispose()

# Also let's extract Es Kopi Susu from Delish House_ Temukan Kuliner Lokal-2.png
$src2 = "d:\LOMBA-KELAS-X\delish-house\assets\template-design\new\Delish House_ Temukan Kuliner Lokal-2.png"
$bmp2 = [System.Drawing.Bitmap]::FromFile($src2)
# Card 2 (Es Kopi Susu) in original home template:
# In category_section_sample (starts at Y=520):
# X: 450, Y in sample: 119 -> Y in original = 520 + 119 = 639
# W: 148, H: 92
$rectKopi = [System.Drawing.Rectangle]::new(450, 639, 148, 92)
$targetKopi = [System.Drawing.Bitmap]::new(148, 92)
$g2 = [System.Drawing.Graphics]::FromImage($targetKopi)
$g2.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g2.DrawImage($bmp2, [System.Drawing.Rectangle]::new(0, 0, 148, 92), $rectKopi, [System.Drawing.GraphicsUnit]::Pixel)
$g2.Dispose()
$kopiPath = Join-Path $foodDir "kopi_susu_home.png"
$targetKopi.Save($kopiPath, [System.Drawing.Imaging.ImageFormat]::Png)
$targetKopi.Dispose()
Write-Host "Saved kopi_susu_home to $kopiPath"

# Card 1 (Ayam Geprek Sambal Matah) in original home template:
$rectGeprek = [System.Drawing.Rectangle]::new(286, 639, 148, 92)
$targetGeprek = [System.Drawing.Bitmap]::new(148, 92)
$g3 = [System.Drawing.Graphics]::FromImage($targetGeprek)
$g3.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g3.DrawImage($bmp2, [System.Drawing.Rectangle]::new(0, 0, 148, 92), $rectGeprek, [System.Drawing.GraphicsUnit]::Pixel)
$g3.Dispose()
$geprekPath = Join-Path $foodDir "ayam_geprek_home.png"
$targetGeprek.Save($geprekPath, [System.Drawing.Imaging.ImageFormat]::Png)
$targetGeprek.Dispose()
Write-Host "Saved ayam_geprek_home to $geprekPath"

$bmp2.Dispose()
