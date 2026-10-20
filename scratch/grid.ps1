Add-Type -AssemblyName System.Drawing

$srcPath = "d:\LOMBA-KELAS-X\delish-house\assets\template-design\new\Delish House_ Temukan Kuliner Lokal-2.png"
$src = [System.Drawing.Bitmap]::FromFile($srcPath)

# Let's crop from Y=45 to Y=375, X=300 to 786:
$crop = $src.Clone((New-Object System.Drawing.Rectangle(300, 45, 486, 330)), $src.PixelFormat)

# Draw grid lines every 50px with coordinate labels
$g = [System.Drawing.Graphics]::FromImage($crop)
$font = New-Object System.Drawing.Font("Arial", 8)
$pen = New-Object System.Drawing.Pen([System.Drawing.Color]::Red, 1)
$brush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::Red)

for ($x = 0; $x -lt $crop.Width; $x += 50) {
    $g.DrawLine($pen, $x, 0, $x, $crop.Height)
    $g.DrawString("X=$($x+300)", $font, $brush, $x + 2, 5)
}

for ($y = 0; $y -lt $crop.Height; $y += 50) {
    $g.DrawLine($pen, 0, $y, $crop.Width, $y)
    $g.DrawString("Y=$($y+45)", $font, $brush, 5, $y + 2)
}

$crop.Save("d:\LOMBA-KELAS-X\delish-house\scratch\hero_with_grid.png", [System.Drawing.Imaging.ImageFormat]::Png)
$crop.Dispose()
$g.Dispose()
$src.Dispose()
Write-Output "Grid saved"
