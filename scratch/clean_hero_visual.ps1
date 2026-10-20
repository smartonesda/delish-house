Add-Type -AssemblyName System.Drawing

$srcPath = "d:\LOMBA-KELAS-X\delish-house\assets\template-design\new\Delish House_ Temukan Kuliner Lokal-2.png"
$src = [System.Drawing.Bitmap]::FromFile($srcPath)

# Let's crop the hero illustration area:
# X: 345 to 786, Y: 35 to 370
# Total width: 441, height: 335
$w = 441
$h = 335
$rect = New-Object System.Drawing.Rectangle(345, 35, $w, $h)
$heroImg = $src.Clone($rect, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)

# Now in $heroImg coordinate system:
# The original X=345 maps to x=0.
# The search button is around:
# original X: 375 to 410 -> x = 30 to 65
# original Y: 254 to 288 -> y: (254 - 35) = 219 to (288 - 35) = 253.
# The "Chat Langsung" tag left portion is around:
# original X: 345 to 395 -> x = 0 to 50
# original Y: 308 to 335 -> y: (308 - 35) = 273 to (335 - 35) = 300.

# Notice that everything to the left of the white torn paper curve is pure background (white)!
# The torn paper curve at y=210 is at x ~ 58.
# At y=290, the bottom-left bubble starts around x ~ 100, and the white curve meets it.
# So everything to the left of the torn paper boundary (x < 55) is background!
# Let's clean x from 0 to 55 up to y=270 by filling with pure white or transparent!
# And for x between 50 and 65, y between 218 and 255:
# Let's inspect each pixel in this region.

$g = [System.Drawing.Graphics]::FromImage($heroImg)

# Let's fill the left background area (where search bar was) with white:
# The search bar left part from x=0 to 50, y=215 to 260
# In fact, the hero background in the design is white (#ffffff)
$brushWhite = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255, 255, 255, 255))

# Also around the tag at x=0 to 55, y=265 to 310, it's all background white
$g.FillRectangle($brushWhite, 0, 265, 58, 50)

# For the search button:
# At y=218..255, the button extends to x=64.
# Behind x=0..50 at y=218..260, it is pure white background!
$g.FillRectangle($brushWhite, 0, 215, 52, 45)

# For x=52..65, y=218..255:
# At y=218, torn paper edge is around x=56, with shadow to x=58, and wood counter at x=59..65.
# At y=255, wood counter is at x=60..65, and torn edge / shadow is at x=55..59.
# Let's see how it looks if we restore the torn paper curve and wood counter texture:
for ($y = 218; $y -le 255; $y++) {
    $t = ($y - 218.0) / (255.0 - 218.0)
    # edgeX shifts smoothly from 57 to 55
    $edgeX = [int](57 - 2 * $t)
    
    # Left of edge is white
    for ($x = 0; $x -lt $edgeX; $x++) {
        $heroImg.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(255, 255, 255, 255))
    }
    # edge pixel is paper edge
    $heroImg.SetPixel($edgeX, $y, [System.Drawing.Color]::FromArgb(255, 248, 250, 252))
    $heroImg.SetPixel($edgeX + 1, $y, [System.Drawing.Color]::FromArgb(255, 230, 235, 240))
    $heroImg.SetPixel($edgeX + 2, $y, [System.Drawing.Color]::FromArgb(255, 210, 215, 220))
    
    # To the right (wood counter and bokeh):
    # interpolate colors from y=216 (top sample) and y=257 (bottom sample)
    for ($x = ($edgeX + 3); $x -le 66; $x++) {
        $topPix = $heroImg.GetPixel($x, 216)
        $botPix = $heroImg.GetPixel($x, 257)
        $r = [int]($topPix.R * (1 - $t) + $botPix.R * $t)
        $gCol = [int]($topPix.G * (1 - $t) + $botPix.G * $t)
        $b = [int]($topPix.B * (1 - $t) + $botPix.B * $t)
        $heroImg.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(255, $r, $gCol, $b))
    }
}

$heroImg.Save("d:\LOMBA-KELAS-X\delish-house\scratch\hero_cleaned.png", [System.Drawing.Imaging.ImageFormat]::Png)
$heroImg.Dispose()
$g.Dispose()
$src.Dispose()
Write-Output "Cleaned hero saved"
