<h1 align="center">wifi-pass</h1>
<p align="center">Bash tool to QR encode, copy or just get the password of current Wi-Fi connection</p>

![Preview](preview.png)

## Install

### Using [bpkg](https://github.com/bpkg/bpkg)

```powershell
bpkg install -g DaFuqtor/wifi-pass
```

### Using `curl`

```powershell
curl wifi-pass.ru | bash
```

### Using Source Code

```powershell
git clone https://github.com/DaFuqtor/wifi-pass
cd wifi-pass
make
```

## Usage

```powershell
wifi-pass [-hV] [options] <ssid>
```

- SSID left empty means **current Wi-Fi network**

- Using **without options** just outputs password

### Options

#### Copy the password to clipboard

```powershell
-c, --copy
```

#### Create QR-code for Wi-Fi connection
> To do this, you need [Homebrew](https://brew.sh/) to `brew install `[`qrencode`](https://fukuchi.org/works/qrencode/index.html.en) first

```powershell
-qr, --qrencode
```
