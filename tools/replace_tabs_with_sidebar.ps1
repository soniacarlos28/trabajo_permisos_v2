Param(
    [string]$Root = "permisos\src\main\webapp\jsp\gestion",
    [int]$Limit = 0,
    [switch]$NoBackup
)

$open = '<div id="apliweb-tabform">'
$close = '</div>'
$incStart = '<%@ include file="/jsp/gestion/includes/layout_start.jsp" %>'
$incEnd = '<%@ include file="/jsp/gestion/includes/layout_end.jsp" %>'
$backupExt = '.bak_apliweb'

if (-not (Test-Path $Root)) {
    Write-Error "Root path not found: $Root"
    exit 2
}

$files = Get-ChildItem -Path $Root -Recurse -Filter '*.jsp' | Sort-Object FullName
$matches = @()
foreach ($f in $files) {
    try {
        $txt = Get-Content -Raw -Encoding UTF8 $f.FullName
        if ($txt -like "*${open}*") {
            $matches += $f.FullName
        }
    } catch {
        Write-Warning "Skipping unreadable: $($f.FullName)"
    }
}

Write-Output "Found $($matches.Count) files with apliweb-tabform"
$toProcess = if ($Limit -gt 0) { $matches[0..([math]::Min($Limit-1,$matches.Count-1))] } else { $matches }
Write-Output "Processing $($toProcess.Count) files"

$changed = @()
foreach ($fp in $toProcess) {
    try {
        $s = Get-Content -Raw -Encoding UTF8 $fp
        $start = $s.IndexOf($open)
        if ($start -lt 0) { Write-Output "No open tag in $fp"; continue }
        $closeIdx = $s.IndexOf($close, $start)
        if ($closeIdx -lt 0) { Write-Output "No closing div after open in $fp"; continue }
        $before = $s.Substring(0,$start)
        $middle = $s.Substring($start + $open.Length, $closeIdx - ($start + $open.Length))
        $after = $s.Substring($closeIdx + $close.Length)
        $new = $before + $incStart + $middle + $incEnd + $after
        if (-not $NoBackup) { Set-Content -Path ($fp + $backupExt) -Value $s -Encoding UTF8 }
        Set-Content -Path $fp -Value $new -Encoding UTF8
        Write-Output "Changed: $fp"
        $changed += $fp
    } catch {
        Write-Warning ("Error processing {0}: {1}" -f $fp, $_)
    }
}

Write-Output "\nDone. Modified $($changed.Count) files."
if ($changed.Count -gt 0) { Write-Output "Backups created with extension $backupExt" }
