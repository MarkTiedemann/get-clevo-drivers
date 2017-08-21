param(
  [string] $hostUrl,
  [string] $file
)

$path = "$pwd\$file"
$dir = split-path $path

if (!(test-path $dir)) {
  new-item $dir -itemtype directory -force | out-null
}

$uri = new-object System.Uri($hostUrl + '/' + $file)
$req = [Net.WebRequest]::Create($uri)
$req.Method = 'RETR'

$res = $req.GetResponse()
$resStream = $res.GetResponseStream()
$fileStream = [System.IO.File]::Create($path)

$buffer = new-object byte[] 1024
while (($read = $resStream.Read($buffer, 0, $buffer.Length)) -gt 0) {
  $fileStream.Write($buffer, 0, $read)
}

$fileStream.Dispose()
$resStream.Dispose()
$res.Dispose()