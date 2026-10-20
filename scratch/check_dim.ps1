Add-Type -AssemblyName System.Drawing

Get-ChildItem "C:\Users\user\.gemini\antigravity-ide\brain\04f0ead5-900b-4e86-8c96-edca94991b1b\.user_uploaded\*.png" | ForEach-Object {
    try {
        $b = [System.Drawing.Bitmap]::FromFile($_.FullName)
        Write-Output "$($_.Name): $($b.Width) x $($b.Height)"
        $b.Dispose()
    } catch {
        Write-Output "$($_.Name): failed to read"
    }
}
