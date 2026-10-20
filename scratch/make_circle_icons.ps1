Add-Type -AssemblyName System.Drawing

function Make-CircularTransparent($inPath, $outPath) {
    $img = [System.Drawing.Bitmap]::FromFile($inPath)
    $w = $img.Width
    $h = $img.Height
    $out = New-Object System.Drawing.Bitmap($w, $h, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $g = [System.Drawing.Graphics]::FromImage($out)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    
    # Create circular path
    $path = New-Object System.Drawing.Drawing2D.GraphicsPath
    # Circle diameter ~ 80% to 85% of image (inside the white border)
    # Let's inspect where the circle is: center is w/2, h/2, radius ~ w * 0.42
    $r = [int]($w * 0.42)
    $cx = [int]($w / 2)
    $cy = [int]($h / 2)
    $path.AddEllipse($cx - $r, $cy - $r, $r * 2, $r * 2)
    
    $g.SetClip($path)
    $g.DrawImage($img, 0, 0, $w, $h)
    
    $out.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose()
    $out.Dispose()
    $img.Dispose()
    Write-Output "Saved $outPath"
}

Make-CircularTransparent "C:\Users\user\.gemini\antigravity-ide\brain\04f0ead5-900b-4e86-8c96-edca94991b1b\step2_kelola_menu_1792475375418.jpg" "d:\LOMBA-KELAS-X\delish-house\assets\icons\step-2-kelola-menu.png"
Make-CircularTransparent "C:\Users\user\.gemini\antigravity-ide\brain\04f0ead5-900b-4e86-8c96-edca94991b1b\step3_jangkau_pelanggan_1792475395190.jpg" "d:\LOMBA-KELAS-X\delish-house\assets\icons\step-3-jangkau-pelanggan.png"
