$packageXml = ''
choco list -lo -r | % { $_ -split '\|' | select -first 1 } | % { $packageXml += "`n<package id=""$_"" />" }
Set-Content .\packages.config "<packages>$packageXml`n</packages>"