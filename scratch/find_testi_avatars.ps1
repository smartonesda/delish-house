Add-Type -AssemblyName System.Drawing

$testi = [System.Drawing.Bitmap]::FromFile("d:\LOMBA-KELAS-X\delish-house\scratch\section_testimoni.png")

function Get-CircleFromCrop($bmp, $startX, $startY, $width, $height) {
    $minX = 999; $maxX = 0; $minY = 999; $maxY = 0;
    for ($y = $startY; $y -lt ($startY + $height); $y++) {
        for ($x = $startX; $x -lt ($startX + $width); $x++) {
            $c = $bmp.GetPixel($x, $y)
            # Avatar background is colored circle, card background is (255,255,255)
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

$s1 = Get-CircleFromCrop $testi 20 15 65 65
Write-Output ("Siti in testi: X=" + $s1.minX + " Y=" + $s1.minY + " W=" + $s1.W + " H=" + $s1.H)

$s2 = Get-CircleFromCrop $testi 275 15 65 65
Write-Output ("Fahri in testi: X=" + $s2.minX + " Y=" + $s2.minY + " W=" + $s2.W + " H=" + $s2.H)

$s3 = Get-CircleFromCrop $testi 525 15 65 65
Write-Output ("Dewi in testi: X=" + $s3.minX + " Y=" + $s3.minY + " W=" + $s3.W + " H=" + $s3.H)

$testi.Dispose()
