Add-Type -AssemblyName System.Drawing

$srcPath = "d:\LOMBA-KELAS-X\delish-house\assets\template-design\new\Delish House_ Temukan Kuliner Lokal-2.png"
$src = [System.Drawing.Bitmap]::FromFile($srcPath)

$cropX = 330
$cropY = 48
$w = 456
$h = 338

$rect = New-Object System.Drawing.Rectangle($cropX, $cropY, $w, $h)
$bmp = $src.Clone($rect, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)

# In $bmp:
# x = original_X - 330
# y = original_Y - 48

# Wipe any text artifact on the far left (x < 24) from y=100 to y=200:
for ($y = 100; $y -le 210; $y++) {
    for ($x = 0; $x -lt 24; $x++) {
        $bmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(255, 255, 255, 255))
    }
}

$edgeX_at_216 = 45
# Smooth transition where the search button was:
for ($y = 217; $y -le 256; $y++) {
    $t = ($y - 217.0) / (256.0 - 217.0)
    $smoothT = (1 - [Math]::Cos($t * [Math]::PI)) / 2.0
    $edgeX = [int]($edgeX_at_216 + (94 - $edgeX_at_216) * $smoothT)
    
    # Left of edge is pure white
    for ($x = 0; $x -lt $edgeX; $x++) {
        $bmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(255, 255, 255, 255))
    }
    $bmp.SetPixel($edgeX, $y, [System.Drawing.Color]::FromArgb(255, 245, 248, 252))
    $bmp.SetPixel($edgeX + 1, $y, [System.Drawing.Color]::FromArgb(255, 225, 232, 240))
    $bmp.SetPixel($edgeX + 2, $y, [System.Drawing.Color]::FromArgb(255, 200, 210, 222))
    
    for ($x = ($edgeX + 3); $x -le 96; $x++) {
        $sampleColor = $bmp.GetPixel($x, 258)
        $bmp.SetPixel($x, $y, $sampleColor)
    }
}

# Below y=256: Clear left of bubble/splash to pure white:
for ($y = 257; $y -lt $h; $y++) {
    $origY = $y + $cropY
    $bubbleX = 94
    if ($origY -ge 305 -and $origY -le 335) {
        $bubbleX = [int](94 - 14 * (($origY - 305.0) / 30.0))
    } elseif ($origY -gt 335) {
        $bubbleX = 74
    }
    
    for ($x = 0; $x -lt $bubbleX; $x++) {
        $bmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(255, 255, 255, 255))
    }
}

# Ensure top-left edge has no artifact
for ($x = 0; $x -lt 80; $x++) {
    $bmp.SetPixel($x, 0, [System.Drawing.Color]::FromArgb(255, 255, 255, 255))
}

$bmp.Save("d:\LOMBA-KELAS-X\delish-house\assets\hero-illustration-main.png", [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()
$src.Dispose()
Write-Output "Hero illustration updated with zero artifacts!"
