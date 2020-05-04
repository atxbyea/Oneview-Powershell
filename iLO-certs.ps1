$username=iLOUser
$password=ConvertTo-SecureString -string "iLOPassword" -AsPlainText -Force
$credential=New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $username,$password
$connection=Connect-HPEiLO -Credential $credential -IP fqdn.domain.local -DisableCertificateAuthentication
Start-HPEiLOCertificateSigningRequest -Connection $connection -City CITY -CommonName fqdn-ilo.domain.local -Country CO -Organization "ORG" -State STATE -OrganizationalUnit ORGUNIT
Get-HPEiLOCertificateSigningRequest -connection $connection

.\certreq.exe -submit -attrib "CertificateTemplate:Webserver" c:\temp\fqdn.csr c:\temp\fqdn.pem

$cert=[IO.file::ReadAllText("C:\temp\fqdn.pem")
Import-HPEiLOCertificate -Certificate $cert -Connection $connection
