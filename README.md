<div align=center>
<h1> Dogwalk Proof-of-Concept🐾</h1>
<pre><code>
<h><strong>🚨 Disclaimer 🚨</strong></h4>
<br>The PoC enables an attacker to be able to obtain <strong>Remote Code Injection</strong> on a Windows victim device. The goal of this repo is to make a PoC even more usable than the <a href=https://github.com/irsl/microsoft-diagcab-rce-poc>initial repo</a>.
<br>DO NOT USE IT WITHOUT PRIOR AUTHORIZATION!
<br><br><i>Regarding the damage caused and the simplicity of exploitation, I hope Microsoft will fix it</i>
</code></pre>
</div> 

***Core concept:*** path traversal vulnerability in Microsoft's Diagcab technology that could lead to remote code execution

You can find the full advisory in the [blog post](https://medium.com/@radimre83/the-trouble-with-microsofts-troubleshooters-6e32fc80b8bd)

The vulnerability has been reported for **2 years** (by [@irsl](https://github.com/irsl) and still has **no fix**!

## How it works?

The Proof-of-Concept set up a webdav server hosting a malicious `.diagcab` file that will perform a path transversal to write a malicious executable in `C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup`. Writing an executable in this folder will execute it each time the user start the windows machine, this is called ***Boot Logon Autostart Execution***.

So, basically what we need is:
* webDAV server
* Malicious `.diagcab` file
* Malicious executable *(legit one or basic text file is sufficient for the PoC)*

### 🎬 Scenario

1. The victim will visit a link (phishing, social engineering, or whatever) that will download the `.diagcab` file

*(💡 use `Content-type: application/octet-stream`response header to make the Browser automaticaly downloading the file when browsing the url)*

2. The victim click on the file download (could easily/accidentaly happen by just clicking on the browser download folder)
3. The cab file loads the webdav malicious executable -> ***(path transversal)** downloaded in Start up menu
4. The user restart his device -> ***(RCE)***

## Let's get it

### 🔨 Craft the  `.diagcab` file

### 🏗️ Set up the server

### 👁️ Wait and see...