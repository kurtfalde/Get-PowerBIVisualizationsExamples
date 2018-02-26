Function Get-RedirectedUrl {
    Param (
        [Parameter(Mandatory=$true)]
        [String]$URL
    )
    $request = [System.Net.WebRequest]::Create($url)
    $request.AllowAutoRedirect=$false
    $response=$request.GetResponse()
    If ($response.StatusCode -eq "Found")
    {
        $response.GetResponseHeader("Location")
    }
}
$PBIVIZURLS = Get-Content C:\temp\PBIVisualsAndExamples\PBI-MSFT-VIZ.txt
$PBIVIZEXAMPLEURLS = Get-Content C:\temp\PBIVisualsAndExamples\PBI-MSFT-VIZ-EXAMPLES.txt

Foreach ($PBIVIZURL in $PBIVIZURLS){
$PBIVIZURL = Get-RedirectedUrl -URL $PBIVIZURL
$Filename = [System.IO.Path]::GetFileName($PBIVIZURL)
$dest = "C:\temp\PBIVisualsAndExamples\$Filename"
Invoke-WebRequest -Uri $PBIVIZURL -OutFile $dest -proxy http://proxyservername
}

Foreach ($PBIVIZEXAMPLEURL in $PBIVIZEXAMPLEURLS){
$Filename = [System.IO.Path]::GetFileName($PBIVIZEXAMPLEURL)
$dest = "C:\temp\PBIVisualsAndExamples\$Filename"
Invoke-WebRequest -Uri $PBIVIZEXAMPLEURL -OutFile $dest -proxy http://proxyservername
}
