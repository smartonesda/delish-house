Add-Type -AssemblyName System.Drawing

function Get-CircleBounds($bmp) {
    $minX = 999; $maxX = 0; $minY = 999; $maxY = 0;
    for ($y = 0; $y -lt $bmp.Height; $y++) {
        for ($x = 0; $x -lt 60; $x++) {
            $c = $bmp.GetPixel($x, $y)
            if ($c.R -lt 240 -or $c.G -lt 240 -or $c.B -lt 240) {
                if ($x -lt $minX) { $minX = $x }
                if ($x -gt $maxX) { $maxX = $x }
                if ($y -lt $minY) { $minY = $y }
                if ($y -gt $maxY) { $maxY = $y }
            }
        }
    }
    return @{minX=$minX; maxX=$maxX; minY=$minY; maxY=$maxY; W=($maxX-$minX+1); H=($maxY-$minY+1)}
}

$siti = [System.Drawing.Bitmap]::FromFile('d:\LOMBA-KELAS-X\delish-house\scratch\siti_sample.png')
$b1 = Get-CircleBounds $siti
Write-Output ("Siti: minX=" + $b1.minX + " minY=" + $b1.minY + " W=" + $b1.W + " H=" + $b1.H)
$siti.Dispose()

$fahri = [System.Drawing.Bitmap]::FromFile('d:\LOMBA-KELAS-X\delish-house\scratch\fahri_sample.png')
$b2 = Get-CircleBounds $fahri
Write-Output ("Fahri: minX=" + $b2.minX + " minY=" + $b2.minY + " W=" + $b2.W + " H=" + $b2.H)
$fahri.Dispose()

$dewi = [System.Drawing.Bitmap]::FromFile('d:\LOMBA-KELAS-X\delish-house\scratch\dewi_sample.png')
$b3 = Get-CircleBounds $dewi
Write-Output ("Dewi: minX=" + $b3.minX + " minY=" + $b3.minY + " W=" + $b3.W + " H=" + $b3.H)
$dewi.Dispose()
