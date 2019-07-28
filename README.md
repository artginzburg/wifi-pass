# wifi-pass
 Bash tool to QR encode, copy or just get the password of current Wi-Fi connection

## Install

```
curl -L https://raw.github.com/DaFuqtor/wifi-pass/master/wifi-pass.sh -o /usr/local/bin/wifi-pass && chmod +x /usr/local/bin/wifi-pass
```

## Usage

```
wifi-pass [option] [ssid]
```

- [ssid] left empty means current Wi-Fi network

- Using without options just outputs password

### Options

#### Copy the password to clipboard

```
-c, --copy
```

#### Create QR-code for Wi-Fi connection
> To do this, you need to `brew install qrencode` first

```
-qr, --qrencode
```