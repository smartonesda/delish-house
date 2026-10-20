Add-Type -AssemblyName System.Drawing

$icon10Path = "d:\LOMBA-KELAS-X\delish-house\assets\icons\icon-10.png"
$icon10 = [System.Drawing.Bitmap]::FromFile($icon10Path)

$size = 512
$bmp = New-Object System.Drawing.Bitmap($size, $size, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic

# Circular background (matching step 2 and step 3)
$margin = 25
$diam = $size - ($margin * 2)
$rect = New-Object System.Drawing.Rectangle($margin, $margin, $diam, $diam)

# Fill with soft blue tint #F0F9FF
$brush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255, 238, 248, 255))
$g.FillEllipse($brush, $rect)

# Draw circle outline #BAE6FD
$pen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(255, 186, 230, 253), 7)
$g.DrawEllipse($pen, $rect)

# Draw icon10 in center
$iconSize = [int]($diam * 0.72)
$iconX = [int](($size - $iconSize) / 2)
$iconY = [int](($size - $iconSize) / 2)
$g.DrawImage($icon10, $iconX, $iconY, $iconSize, $iconSize)

$bmp.Save("d:\LOMBA-KELAS-X\delish-house\assets\icons\step-1-daftarkan-usaha.png", [System.Drawing.Imaging.ImageFormat]::Png)

$g.Dispose()
$bmp.Dispose()
$icon10.Dispose()
Write-Output "Created step-1-daftarkan-usaha.png successfully"
