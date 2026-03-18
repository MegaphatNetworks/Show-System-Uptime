Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create the form
$form = New-Object Windows.Forms.Form
$form.FormBorderStyle = 'None'
$form.TopMost = $true
$form.BackColor = 'Black'
$form.TransparencyKey = 'Black'
$form.StartPosition = 'Manual'
$form.Location = [System.Drawing.Point]::new([System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Width - 200, 0)
$form.Size = [System.Drawing.Size]::new(200, 50)
$form.ShowInTaskbar = $false

# Create the label
$label = New-Object Windows.Forms.Label
$label.ForeColor = 'Red'
$label.BackColor = 'Transparent'
$label.Font = New-Object Drawing.Font('Consolas', 12, [System.Drawing.FontStyle]::Bold)
$label.Dock = 'Fill'
$label.TextAlign = 'MiddleCenter'
$form.Controls.Add($label)

# Timer to update uptime
$timer = New-Object Windows.Forms.Timer
$timer.Interval = 1000
$timer.Add_Tick({
    $boot = (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
    $uptime = New-TimeSpan -Start $boot
    $label.Text = "Uptime: {0:dd\.hh\:mm\:ss}" -f $uptime
    $form.Refresh()  # Force redraw to reduce flicker
})

$timer.Start()
[void]$form.ShowDialog()
