Add-Type -AssemblyName System.Drawing

$srcPath = "C:\Users\user\.gemini\antigravity-ide\brain\04f0ead5-900b-4e86-8c96-edca94991b1b\.user_uploaded\media_1792474828459.png"
$src = [System.Drawing.Bitmap]::FromFile($srcPath)

# Total 437 x 195
# Step 1: X ~ 30 to 150, Y ~ 10 to 110
# Step 2: X ~ 170 to 290, Y ~ 10 to 110
# Step 3: X ~ 310 to 430, Y ~ 10 to 110

$rect1 = New-Object System.Drawing.Rectangle(30, 5, 110, 105)
$src.Clone($rect1, $src.PixelFormat).Save("d:\LOMBA-KELAS-X\delish-house\scratch\step1_zoom.png")

$rect2 = New-Object System.Drawing.Rectangle(175, 5, 110, 105)
$src.Clone($rect2, $src.PixelFormat).Save("d:\LOMBA-KELAS-X\delish-house\scratch\step2_zoom.png")

$rect3 = New-Object System.Drawing.Rectangle(320, 5, 110, 105)
$src.Clone($rect3, $src.PixelFormat).Save("d:\LOMBA-KELAS-X\delish-house\scratch\step3_zoom.png")

$src.Dispose()
Write-Output "Cropped step zooms"
