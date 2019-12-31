$packageXml = ''

choco list -lo -r |
    % { $_ -split '\|' | select -first 1 } |
    Where-Object {
        $_ -CNotMatch "chocolatey" -And
        $_ -CNotMatch "\.install$" -And
        $_ -CNotMatch "\.extension$" -And
        $_ -CNotMatch "\.commandline$" -And
        $_ -CNotMatch "\.portable$" -And
        $_ -CNotMatch "^jre" -And
        $_ -CNotMatch "^KB" -And
        $_ -CNotMatch "^DotNet" -And
        $_ -CNotMatch "^netfx." -And
        $_ -CNotMatch "python." -And
        $_ -CNotMatch "vcredist[^\\-]"
    } |
    % { $packageXml += "`n<package id=""$_"" />" }

Set-Content .\packages.config "<packages>$packageXml`n</packages>"
