Add-Type -AssemblyName System.Drawing

$srcPath = "d:\LOMBA-KELAS-X\delish-house\assets\template-design\new\Delish House_ Temukan Kuliner Lokal-2.png"
$src = [System.Drawing.Bitmap]::FromFile($srcPath)

# Source bounds for the hero visual:
# X: 330 to 786 (Width = 456)
# Y: 46 to 372 (Height = 326)
$cropX = 330
$cropY = 46
$w = 456
$h = 326

$rect = New-Object System.Drawing.Rectangle($cropX, $cropY, $w, $h)
$bmp = $src.Clone($rect, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)

# In $bmp:
# coordinate x = original_X - 330
# coordinate y = original_Y - 46

# Torn paper boundary:
# At original Y=150 (y=104), edge is around original X=358 (x=28)
# At original Y=200 (y=154), edge is around original X=376 (x=46)
# At original Y=230 (y=184), edge curves to original X=390 (x=60)
# At original Y=255 (y=209), edge curves to original X=402 (x=72)
# At original Y=270 (y=224), edge curves to original X=405 (x=75)
# At original Y=290 (y=244), edge meets the speech bubble at original X=430 (x=100)

# The search bar / button was at:
# original X: 330..412 -> x: 0..82
# original Y: 265..305 -> y: 219..259
# The tag was at:
# original X: 330..410 -> x: 0..80
# original Y: 315..345 -> y: 269..299

# Everything to the left of the torn paper and speech bubble is pure white (#FFFFFF)!
# Let's cleanly define the torn paper edge path from y=180 to y=255:
# and speech bubble edge from y=250 to y=305:

# Let's inspect each line y:
for ($y = 0; $y -lt $h; $y++) {
    $origY = $y + $cropY
    
    # Calculate boundary X where content begins:
    if ($origY -lt 210) {
        # Above search bar: find first non-white pixel or torn paper edge
        # We leave as is, but ensure anything before x=25 is white
        continue
    }
    elseif ($origY -ge 210 -and $origY -le 268) {
        # Between Y=210 and Y=268: the torn paper curve goes from x=60 at Y=210 to x=76 at Y=268
        $t = ($origY - 210.0) / (268.0 - 210.0)
        $edgeX = [int](58 + 18 * [Math]::Sin($t * [Math]::PI / 2))
        
        # Clear everything left of edgeX to white
        for ($x = 0; $x -lt $edgeX; $x++) {
            $bmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(255, 255, 255, 255))
        }
        # Subtle paper edge anti-aliasing / shadow
        $bmp.SetPixel($edgeX, $y, [System.Drawing.Color]::FromArgb(255, 245, 248, 252))
        $bmp.SetPixel($edgeX + 1, $y, [System.Drawing.Color]::FromArgb(255, 225, 230, 238))
        $bmp.SetPixel($edgeX + 2, $y, [System.Drawing.Color]::FromArgb(255, 195, 205, 215))
        
        # In the region where search button was (origY 270..303):
        # We will handle below
    }
    elseif ($origY -gt 268 -and $origY -le 305) {
        # Y=268 to 305: search button region!
        # At Y=268, paper edge was at x=76.
        # Below Y=270, the wooden tray begins at x=80, and the white speech bubble begins at x=98.
        # So from x=0 to x=76 is pure white.
        # Between x=77 and x=85 is the torn edge meeting the wooden tray.
        # Between x=86 and x=98 is the wooden tray edge (continuing the texture from Y=306).
        $t = ($origY - 268.0) / (305.0 - 268.0)
        $edgeX = [int](76 + 18 * $t)
        
        for ($x = 0; $x -lt $edgeX; $x++) {
            $bmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(255, 255, 255, 255))
        }
        $bmp.SetPixel($edgeX, $y, [System.Drawing.Color]::FromArgb(255, 240, 244, 250))
        $bmp.SetPixel($edgeX + 1, $y, [System.Drawing.Color]::FromArgb(255, 210, 220, 230))
        
        # Sample texture for wooden counter from Y=306:
        for ($x = ($edgeX + 2); $x -le 96; $x++) {
            $sampleColor = $bmp.GetPixel($x, 306 - $cropY)
            $bmp.SetPixel($x, $y, $sampleColor)
        }
    }
    elseif ($origY -gt 305) {
        # Below search button: the tag "Chat Langsung" was at x=0..75
        # The speech bubble starts at x=95 at Y=305 and x=90 at Y=320, then x=85 at Y=340
        # Anything to the left of the speech bubble / orange curve is white:
        $bubbleStartX = 88
        if ($origY -gt 335) {
            $bubbleStartX = 75 # meets orange splash
        }
        for ($x = 0; $x -lt $bubbleStartX; $x++) {
            $bmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(255, 255, 255, 255))
        }
    }
}

$bmp.Save("d:\LOMBA-KELAS-X\delish-house\scratch\hero_perfect_crop.png", [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()
$src.Dispose()
Write-Output "Perfect crop saved"
