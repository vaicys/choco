$packageXml = ''

choco list -lo -r |
    % { $_ -split '\|' | select -first 1 } |
    Where-Object {
        $_ -NotMatch "chocolatey" -And
        $_ -NotMatch "\.install$" -And
        $_ -NotMatch "\.extension$" -And
        $_ -NotMatch "\.commandline$" -And
        $_ -NotMatch "\.portable$" -And
        $_ -NotMatch "^jre" -And
        $_ -NotMatch "^KB" -And
        $_ -CNotMatch "^DotNet" -And
        $_ -NotMatch "^dotnet4.7" -And
        $_ -NotMatch "^dotnetcore" -And
        $_ -NotMatch "^dotnet-[^sdk]" -And
        $_ -NotMatch "^netfx." -And
        $_ -NotMatch "python." -And
        $_ -NotMatch "vcredist[^\\-]" -And
        $_ -NotMatch "teamviewer" -And
        $_ -NotMatch "anki" -And
        $_ -NotMatch "mpc-hc"
    } |
    % { $packageXml += "`n<package id=""$_"" />" }

Set-Content .\packages.config "<packages>$packageXml`n</packages>"
