$username = Read-Host -Prompt 'Input username'
$password = Read-Host -AsSecureString 'Input password
$IP = Read-Host -Prompt 'Input hostname of iLO'
$city = Read-Host -Prompt 'Input City'
$country = Read-Host -Prompt 'Input Country'
$organization = Read-Host -Prompt 'Input Organization Name'
$orgunit = Read-Host -Prompt 'Input Organizational Unit'
$state = Read-Host -Prompt 'Input State'

$credential = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $username,$password
$connection = Connect-HPEiLO -Credential $credential -IP $IP -DisableCertificateAuthentication
Start-HPEiLOCertificateSigningRequest -Connection $connection -City $city -CommonName $IP -Country $country -Organization $organization -State $state -OrganizationalUnit $orgunit
Get-HPEiLOCertificateSigningRequest -connection $connection

.\certreq.exe -submit -attrib "CertificateTemplate:Webserver" c:\temp\fqdn.csr c:\temp\fqdn.pem

$cert=[IO.file::ReadAllText("C:\temp\fqdn.pem")
Import-HPEiLOCertificate -Certificate $cert -Connection $connection
