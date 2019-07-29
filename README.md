<h1 align="center">wifi-pass</h1>
<p align="center">Bash tool to QR encode, copy or just get the password of current Wi-Fi connection</p>

## Install

### Using [bpkg](https://github.com/bpkg/bpkg)

```powershell
bpkg install -g DaFuqtor/wifi-pass
```

### Using `curl`

```powershell
curl -L https://raw.github.com/DaFuqtor/wifi-pass/master/wifi-pass.sh -o /usr/local/bin/wifi-pass && chmod +x /usr/local/bin/wifi-pass
```

### Using Source Code

```powershell
git clone https://github.com/DaFuqtor/wifi-pass.git
cd wifi-pass
make
```

## Usage

```powershell
wifi-pass [option] [ssid]
```

- [ssid] left empty means current Wi-Fi network

- Using without options just outputs password

### Options

#### Copy the password to clipboard

```powershell
-c, --copy
```

#### Create QR-code for Wi-Fi connection
> To do this, you need to `brew install qrencode` first

```powershell
-qr, --qrencode
```