Add-Type -AssemblyName System.Drawing

$src = [System.Drawing.Bitmap]::FromFile("d:\LOMBA-KELAS-X\delish-house\assets\template-design\new\Delish House_ Temukan Kuliner Lokal-2.png")

function Find-CircleBounds($bmp, $startX, $startY) {
    $minX = 999; $maxX = 0; $minY = 999; $maxY = 0;
    for ($y = $startY; $y -lt ($startY + 80); $y++) {
        for ($x = $startX; $x -lt ($startX + 80); $x++) {
            $c = $bmp.GetPixel($x, $y)
            # Find non-white avatar background (Siti is warm orange/yellow circle, Fahri is blue/cyan circle, Dewi is orange circle)
            # White card background is (255, 255, 255)
            if ($c.R -lt 250 -or $c.G -lt 250 -or $c.B -lt 250) {
                if ($x -lt $minX) { $minX = $x }
                if ($x -gt $maxX) { $maxX = $x }
                if ($y -lt $minY) { $minY = $y }
                if ($y -gt $maxY) { $maxY = $y }
            }
        }
    }
    return @{minX=$minX; maxX=$maxX; minY=$minY; maxY=$maxY; W=($maxX-$minX+1); H=($maxY-$minY+1)}
}

$s1 = Find-CircleBounds $src 20 1515
Write-Output ("Siti: minX=" + $s1.minX + " minY=" + $s1.minY + " W=" + $s1.W + " H=" + $s1.H)

$s2 = Find-CircleBounds $src 275 1515
Write-Output ("Fahri: minX=" + $s2.minX + " minY=" + $s2.minY + " W=" + $s2.W + " H=" + $s2.H)

$s3 = Find-CircleBounds $src 525 1515
Write-Output ("Dewi: minX=" + $s3.minX + " minY=" + $s3.minY + " W=" + $s3.W + " H=" + $s3.H)

$src.Dispose()
