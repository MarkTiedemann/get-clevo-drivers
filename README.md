# get-clevo-drivers

**List or download [Clevo drivers](http://www.clevo.com/en/e-services/Download/default.asp).**

## Quickstart

```powershell
$hostUrl = 'ftp://usftp.clevo.com.tw'
$path = 'P6xxHS'

# List all drivers
$list = .\list.ps1 $hostUrl $path

# Download and unzip all drivers
$list | % {
  write-host downloading $_
  .\download.ps1 $hostUrl $_
  .\unzip.ps1 $_
}
```

## License

[WTFPL](http://www.wtfpl.net/) – Do What the F*ck You Want to Public License.

Made with :heart: by [@MarkTiedemann](https://twitter.com/MarkTiedemannDE).