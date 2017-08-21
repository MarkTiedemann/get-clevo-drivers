param(
  [string] $file
)

$dir = [System.IO.Path]::GetDirectoryName($file)
$name = [System.IO.Path]::GetFileNameWithoutExtension($file)
expand-archive $file -dest "$dir\$name"
remove-item $file -force