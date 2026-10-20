Add-Type -AssemblyName System.Drawing

$src = [System.Drawing.Bitmap]::FromFile("d:\LOMBA-KELAS-X\delish-house\assets\icons\icon-10.png")
$w = $src.Width
$h = $src.Height

# Make near white transparent
$transBmp = New-Object System.Drawing.Bitmap($w, $h, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
for ($y = 0; $y -lt $h; $y++) {
    for ($x = 0; $x -lt $w; $x++) {
        $c = $src.GetPixel($x, $y)
        # If very close to pure white (#FDFDFD - #FFFFFF)
        if ($c.R -gt 248 -and $c.G -gt 248 -and $c.B -gt 248) {
            $transBmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(0, 255, 255, 255))
        } else {
            $transBmp.SetPixel($x, $y, $c)
        }
    }
}

# Now compose into circular container matching step 2 and 3
$size = 512
$bmp = New-Object System.Drawing.Bitmap($size, $size, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic

$margin = 25
$diam = $size - ($margin * 2)
$rect = New-Object System.Drawing.Rectangle($margin, $margin, $diam, $diam)

# Fill with soft blue tint #EEF7FF
$brush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255, 238, 247, 255))
$g.FillEllipse($brush, $rect)

# Draw circle outline #BAE6FD
$pen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(255, 186, 230, 253), 7)
$g.DrawEllipse($pen, $rect)

# Draw storefront in center
$iconSize = [int]($diam * 0.76)
$iconX = [int](($size - $iconSize) / 2)
$iconY = [int](($size - $iconSize) / 2)
$g.DrawImage($transBmp, $iconX, $iconY, $iconSize, $iconSize)

$bmp.Save("d:\LOMBA-KELAS-X\delish-house\assets\icons\step-1-daftarkan-usaha.png", [System.Drawing.Imaging.ImageFormat]::Png)

$g.Dispose()
$bmp.Dispose()
$transBmp.Dispose()
$src.Dispose()
Write-Output "Successfully created clean step-1-daftarkan-usaha.png"
