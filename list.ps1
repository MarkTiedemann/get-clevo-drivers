param(
  [string] $hostUrl,
  [string] $path = ''
)

$files = @()

function parse ($lines) {
  $lines | % {

    $fields = $_.Split(' ') |
      % { $_.Trim() } |
      where { $_ -ne '' }

    new-object psobject -property @{
      isDirectory = ($fields | select -first 1).StartsWith('d')
      name = $fields | select -last 1
    }
  } |
  where {$_.name -ne '.' } |
  where { $_.name -ne '..' }
}

function list ($hostUrl, $path) {
  $uri = new-object System.Uri(($hostUrl + '/' + $path))
  $req = [Net.WebRequest]::Create($uri)
  $req.Method = 'LIST'

  $lines = @()

  $res = $req.GetResponse()
  $resStream = $res.GetResponseStream()
  $resReader = new-object System.IO.StreamReader $resStream

  while (!$resReader.EndOfStream) {
    $lines += $resReader.ReadLine()
  }

  $resReader.Dispose()
  $resStream.Dispose()
  $res.Dispose()

  parse $lines $path |
  % { $_.name = $path + '/' + $_.name; $_ } |
  % {
    if ($_.isDirectory) { list $hostUrl $_.name }
    else { $files += $_.name }
  }

  $files
}

list $hostUrl $path