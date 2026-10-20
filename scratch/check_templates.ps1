Add-Type -AssemblyName System.Drawing

$files = @(
  "Delish House UMKM Landing Page.png",
  "Cara Kerja Delish House.png",
  "Jelajahi Kuliner Lokal Delish House.png"
)

foreach ($f in $files) {
  $p = Join-Path "d:\LOMBA-KELAS-X\delish-house\assets\template-design\new" $f
  if (Test-Path $p) {
    $img = [System.Drawing.Bitmap]::FromFile($p)
    $rect = New-Object System.Drawing.Rectangle(0, 0, $img.Width, [Math]::Min(400, $img.Height))
    $crop = $img.Clone($rect, $img.PixelFormat)
    $outName = "d:\LOMBA-KELAS-X\delish-house\scratch\sample_" + ($f -replace ' ', '_')
    $crop.Save($outName, [System.Drawing.Imaging.ImageFormat]::Png)
    $crop.Dispose()
    $img.Dispose()
    Write-Output "Saved $outName"
  }
}
