Configuration ContosoWebsite
{
  param ($MachineName)

  Node $MachineName
  {

    
    $sourceFile = "http://www.compit.se/download/MSI/VLC%20Media%20Player-x64-v2.1.5.msi"
    $destFile = "c:\users\public\documents\vlc.msi"
    Invoke-WebRequest $sourceFile -outFile $destFile
    $process = Start-Process $destFile -ArgumentList "/qn" -Wait -PassThru
    $ptime = get-date
    $text = ("VLC status: " + $process.ExitCode + "at " +$ptime) | Out-File 'c:\users\public\documents\DSClog.txt' -Append

    #Install the IIS Role
    WindowsFeature IIS
    {
      Ensure = “Present”
      Name = “Web-Server”
    }
    
    $ptime = get-date 
    $text = ("IIS installation complete at: " + $ptime) | Out-File 'c:\users\public\documents\DSClog.txt' -Append

    #Install ASP.NET 4.5
    WindowsFeature ASP
    {
      Ensure = “Present”
      Name = “Web-Asp-Net45”
    }

     $ptime = get-date
     $text = ("ASP.NET installation complete at: " +$ptime) | Out-File 'c:\users\public\documents\DSClog.txt' -Append
     
     WindowsFeature WebServerManagementConsole
    {
        Name = "Web-Mgmt-Console"
        Ensure = "Present"
    }
  }
} 
