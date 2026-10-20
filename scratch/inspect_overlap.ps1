Add-Type -AssemblyName System.Drawing

$srcPath = "d:\LOMBA-KELAS-X\delish-house\assets\template-design\new\Delish House_ Temukan Kuliner Lokal-2.png"
$src = [System.Drawing.Bitmap]::FromFile($srcPath)

# Let's crop just the area around the search button to see the pixels:
# in the image coordinate system:
$rect = New-Object System.Drawing.Rectangle(360, 240, 80, 80)
$crop = $src.Clone($rect, $src.PixelFormat)
$crop.Save("d:\LOMBA-KELAS-X\delish-house\scratch\search_button_overlap.png", [System.Drawing.Imaging.ImageFormat]::Png)
$crop.Dispose()
$src.Dispose()
Write-Output "Search overlap saved"
