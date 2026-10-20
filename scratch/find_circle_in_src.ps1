Add-Type -AssemblyName System.Drawing

$src = [System.Drawing.Bitmap]::FromFile("d:\LOMBA-KELAS-X\delish-house\assets\template-design\new\Delish House_ Temukan Kuliner Lokal-2.png")

# Let's inspect Siti around X=15..80, Y=1505..1575
# And Fahri around X=270..340
# And Dewi around X=520..590

function Find-Circle($startX, $startY) {
    global:src
    $minX = 999; $maxX = 0; $minY = 999; $maxY = 0;
    for ($y = $startY; $y -lt ($startY + 70); $y++) {
        for ($x = $startX; $x -lt ($startX + 80); $x++) {
            $c = $src.GetPixel($x, $y)
            # Not white (#FFFFFF or near white) and not the card border
            if (($c.R -lt 245 -or $c.G -lt 245 -or $c.B -lt 245) -and ($c.R -gt 100 -or $c.G -gt 100)) {
                if ($x -lt $minX) { $minX = $x }
                if ($x -gt $maxX) { $maxX = $x }
                if ($y -lt $minY) { $minY = $y }
                if ($y -gt $maxY) { $maxY = $y }
            }
        }
    }
    return @{minX=$minX; maxX=$maxX; minY=$minY; maxY=$maxY; W=($maxX-$minX+1); H=($maxY-$minY+1)}
}

$s1 = Find-Circle 20 1510
Write-Output ("Siti bounds in src: " + $s1.minX + "," + $s1.minY + " W=" + $s1.W + " H=" + $s1.H)

$s2 = Find-Circle 270 1510
Write-Output ("Fahri bounds in src: " + $s2.minX + "," + $s2.minY + " W=" + $s2.W + " H=" + $s2.H)

$s3 = Find-Circle 520 1510
Write-Output ("Dewi bounds in src: " + $s3.minX + "," + $s3.minY + " W=" + $s3.W + " H=" + $s3.H)

$src.Dispose()
