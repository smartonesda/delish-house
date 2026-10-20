Add-Type -AssemblyName System.Drawing

$srcPath = "d:\LOMBA-KELAS-X\delish-house\assets\template-design\new\Delish House_ Temukan Kuliner Lokal-2.png"
$src = [System.Drawing.Bitmap]::FromFile($srcPath)

$cropX = 330
$cropY = 48
$w = 456
$h = 338

$rect = New-Object System.Drawing.Rectangle($cropX, $cropY, $w, $h)
$bmp = $src.Clone($rect, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$src.Dispose()

# Wipe text artifact on far left
for ($y = 100; $y -le 210; $y++) {
    for ($x = 0; $x -lt 24; $x++) {
        $bmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(255, 255, 255, 255))
    }
}

$edgeX_at_216 = 45
# Smooth transition where search button was
for ($y = 217; $y -le 256; $y++) {
    $t = ($y - 217.0) / (256.0 - 217.0)
    $smoothT = (1 - [Math]::Cos($t * [Math]::PI)) / 2.0
    $edgeX = [int]($edgeX_at_216 + (94 - $edgeX_at_216) * $smoothT)
    
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

# Below y=256: clear left of bubble to pure white
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

for ($x = 0; $x -lt 80; $x++) {
    $bmp.SetPixel($x, 0, [System.Drawing.Color]::FromArgb(255, 255, 255, 255))
}

# Now perform flood fill transparency from all 4 borders
$visited = New-Object 'bool[,]' $w, $h
$queue = New-Object System.Collections.Generic.Queue[System.Drawing.Point]

$botY = $h - 1
$rightX = $w - 1

for ($x = 0; $x -lt $w; $x++) {
    $pTop = $bmp.GetPixel($x, 0)
    if ($pTop.R -gt 242 -and $pTop.G -gt 242 -and $pTop.B -gt 242) {
        $queue.Enqueue((New-Object System.Drawing.Point($x, 0)))
        $visited[$x, 0] = $true
    }
    $pBot = $bmp.GetPixel($x, $botY)
    if ($pBot.R -gt 242 -and $pBot.G -gt 242 -and $pBot.B -gt 242) {
        $queue.Enqueue((New-Object System.Drawing.Point($x, $botY)))
        $visited[$x, $botY] = $true
    }
}

for ($y = 0; $y -lt $h; $y++) {
    $pLeft = $bmp.GetPixel(0, $y)
    if ($pLeft.R -gt 242 -and $pLeft.G -gt 242 -and $pLeft.B -gt 242) {
        if (-not $visited[0, $y]) {
            $queue.Enqueue((New-Object System.Drawing.Point(0, $y)))
            $visited[0, $y] = $true
        }
    }
    $pRight = $bmp.GetPixel($rightX, $y)
    if ($pRight.R -gt 242 -and $pRight.G -gt 242 -and $pRight.B -gt 242) {
        if (-not $visited[$rightX, $y]) {
            $queue.Enqueue((New-Object System.Drawing.Point($rightX, $y)))
            $visited[$rightX, $y] = $true
        }
    }
}

$dx = @(1, -1, 0, 0)
$dy = @(0, 0, 1, -1)

while ($queue.Count -gt 0) {
    $pt = $queue.Dequeue()
    # Fully transparent
    $bmp.SetPixel($pt.X, $pt.Y, [System.Drawing.Color]::FromArgb(0, 0, 0, 0))
    
    for ($i = 0; $i -lt 4; $i++) {
        $nx = $pt.X + $dx[$i]
        $ny = $pt.Y + $dy[$i]
        
        if ($nx -ge 0 -and $nx -lt $w -and $ny -ge 0 -and $ny -lt $h) {
            if (-not $visited[$nx, $ny]) {
                $p = $bmp.GetPixel($nx, $ny)
                if ($p.R -gt 242 -and $p.G -gt 242 -and $p.B -gt 242) {
                    $visited[$nx, $ny] = $true
                    $queue.Enqueue((New-Object System.Drawing.Point($nx, $ny)))
                }
            }
        }
    }
}

# Soft anti-aliasing / edge feathering
for ($y = 1; $y -lt ($h - 1); $y++) {
    for ($x = 1; $x -lt ($w - 1); $x++) {
        $p = $bmp.GetPixel($x, $y)
        if ($p.A -gt 0 -and $p.R -gt 238 -and $p.G -gt 238 -and $p.B -gt 238) {
            $isNearTransparent = $false
            for ($i = 0; $i -lt 4; $i++) {
                if ($bmp.GetPixel($x + $dx[$i], $y + $dy[$i]).A -eq 0) {
                    $isNearTransparent = $true
                    break
                }
            }
            if ($isNearTransparent) {
                $bmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(100, $p.R, $p.G, $p.B))
            }
        }
    }
}

$outPath = "d:\LOMBA-KELAS-X\delish-house\assets\hero-illustration-main.png"
$bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()
Write-Output "Transparent hero illustration perfectly generated"
