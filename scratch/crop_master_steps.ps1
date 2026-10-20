Add-Type -AssemblyName System.Drawing

$src = [System.Drawing.Bitmap]::FromFile("d:\LOMBA-KELAS-X\delish-house\assets\template-design\new\Delish House_ Temukan Kuliner Lokal-2.png")

# Let's inspect the positions of the 3 circular icons in the strip
# In the strip, Y was 830 to 1090.
# Step 1:
# Number '1' orange circle is around X ~ 305 to 335, Y ~ 830 to 860
# Icon 1 circle is around X ~ 320 to 395, Y ~ 845 to 920

# Let's crop each step circle with its number badge included!
# Step 1 (badge + circle):
$s1 = New-Object System.Drawing.Rectangle(305, 830, 95, 95)
$src.Clone($s1, $src.PixelFormat).Save("d:\LOMBA-KELAS-X\delish-house\scratch\step_1_raw.png")

# Step 2:
# Orange arrow is between step 1 and 2
# Number '2' blue circle is around X ~ 465 to 495
# Icon 2 circle is around X ~ 480 to 555
$s2 = New-Object System.Drawing.Rectangle(468, 830, 95, 95)
$src.Clone($s2, $src.PixelFormat).Save("d:\LOMBA-KELAS-X\delish-house\scratch\step_2_raw.png")

# Step 3:
# Number '3' green circle is around X ~ 630 to 660
# Icon 3 circle is around X ~ 645 to 720
$s3 = New-Object System.Drawing.Rectangle(632, 830, 95, 95)
$src.Clone($s3, $src.PixelFormat).Save("d:\LOMBA-KELAS-X\delish-house\scratch\step_3_raw.png")

$src.Dispose()
Write-Output "Cropped raw steps"
