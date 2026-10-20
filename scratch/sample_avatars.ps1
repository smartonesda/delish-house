Add-Type -AssemblyName System.Drawing
$src = [System.Drawing.Bitmap]::FromFile("d:\LOMBA-KELAS-X\delish-house\assets\template-design\new\Delish House_ Temukan Kuliner Lokal-2.png")

# Crop broader area to see exact circle bounds
$crop1 = $src.Clone((New-Object System.Drawing.Rectangle(35, 1510, 75, 75)), $src.PixelFormat)
$crop1.Save("d:\LOMBA-KELAS-X\delish-house\scratch\siti_sample.png")
$crop1.Dispose()

$crop2 = $src.Clone((New-Object System.Drawing.Rectangle(290, 1510, 75, 75)), $src.PixelFormat)
$crop2.Save("d:\LOMBA-KELAS-X\delish-house\scratch\fahri_sample.png")
$crop2.Dispose()

$crop3 = $src.Clone((New-Object System.Drawing.Rectangle(540, 1510, 75, 75)), $src.PixelFormat)
$crop3.Save("d:\LOMBA-KELAS-X\delish-house\scratch\dewi_sample.png")
$crop3.Dispose()

$src.Dispose()
Write-Output "Avatar samples saved"
