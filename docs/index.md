<h1 align="center">wifi-pass</h1>

<p align="center">Terminal tool to QR encode, copy or just get the password of current Wi-Fi connection</p>

[![Preview](preview.png)](https://raw.githubusercontent.com/DaFuqtor/wifi-pass/master/preview.png)

## Installation

> Paste this to your Terminal

```powershell
curl wifi-pass.ru | sh
```

## Usage

```powershell
wifi-pass [-hV] [options] [<ssid>]
          [-u,  --update]    # Check for update and ask to install
        # Options:
          [-c,  --copy]      # Copy the password to clipboard
          [-qr, --qrencode]  # Create QR-code for Wi-Fi connection
          [-l,  --list]      # Display a list of all stored networks
```

- SSID left empty means **current Wi-Fi network**

- Using **without options** just outputs password