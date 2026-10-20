Add-Type -AssemblyName System.Drawing

$src = [System.Drawing.Bitmap]::FromFile("d:\LOMBA-KELAS-X\delish-house\assets\template-design\new\Delish House_ Temukan Kuliner Lokal-2.png")

# Card 1 left border is around X=26. Avatar is around X=42 to 92 (50x50).
# Let's crop X=38 to 92, Y=1516 to 1570
$crop1 = $src.Clone((New-Object System.Drawing.Rectangle(40, 1517, 50, 50)), $src.PixelFormat)
$crop1.Save("d:\LOMBA-KELAS-X\delish-house\assets\new\avatar-siti.png")
$crop1.Dispose()

# Fahri:
$crop2 = $src.Clone((New-Object System.Drawing.Rectangle(297, 1517, 50, 50)), $src.PixelFormat)
$crop2.Save("d:\LOMBA-KELAS-X\delish-house\assets\new\avatar-fahri.png")
$crop2.Dispose()

# Dewi:
$crop3 = $src.Clone((New-Object System.Drawing.Rectangle(546, 1517, 50, 50)), $src.PixelFormat)
$crop3.Save("d:\LOMBA-KELAS-X\delish-house\assets\new\avatar-dewi.png")
$crop3.Dispose()

$src.Dispose()
Write-Output "Extracted clean centered avatars"
