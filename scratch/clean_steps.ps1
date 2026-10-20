Add-Type -AssemblyName System.Drawing

function Create-CleanStepBadge($srcPath, $outPath, $badgeCenter, $circleCenter, $badgeRadius, $circleRadius) {
    $src = [System.Drawing.Bitmap]::FromFile($srcPath)
    $w = $src.Width
    $h = $src.Height
    $out = New-Object System.Drawing.Bitmap($w, $h, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $g = [System.Drawing.Graphics]::FromImage($out)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    
    $path = New-Object System.Drawing.Drawing2D.GraphicsPath
    # Add circle
    $path.AddEllipse($circleCenter.X - $circleRadius, $circleCenter.Y - $circleRadius, $circleRadius * 2, $circleRadius * 2)
    # Add badge circle
    $path.AddEllipse($badgeCenter.X - $badgeRadius, $badgeCenter.Y - $badgeRadius, $badgeRadius * 2, $badgeRadius * 2)
    
    $g.SetClip($path)
    $g.DrawImage($src, 0, 0, $w, $h)
    
    $out.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose()
    $out.Dispose()
    $src.Dispose()
    Write-Output "Created $outPath"
}

# In 95x95 image:
# Badge 1 center is roughly (18, 18), radius 14
# Circle 1 center is roughly (54, 52), radius 38
Create-CleanStepBadge "d:\LOMBA-KELAS-X\delish-house\scratch\step_1_raw.png" "d:\LOMBA-KELAS-X\delish-house\scratch\step_1_clean.png" (New-Object System.Drawing.Point(18, 18)) (New-Object System.Drawing.Point(54, 52)) 14 38
Create-CleanStepBadge "d:\LOMBA-KELAS-X\delish-house\scratch\step_2_raw.png" "d:\LOMBA-KELAS-X\delish-house\scratch\step_2_clean.png" (New-Object System.Drawing.Point(18, 18)) (New-Object System.Drawing.Point(54, 52)) 14 38
Create-CleanStepBadge "d:\LOMBA-KELAS-X\delish-house\scratch\step_3_raw.png" "d:\LOMBA-KELAS-X\delish-house\scratch\step_3_clean.png" (New-Object System.Drawing.Point(18, 18)) (New-Object System.Drawing.Point(54, 52)) 14 38
