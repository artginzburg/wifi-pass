<h1 align="center">wifi-pass</h1>
<p align="center">Bash tool to QR encode, copy or just get the password of current Wi-Fi connection</p>

![Preview](preview.png)

## Install

### Using `curl`

```powershell
curl wifi-pass.ru | bash
```

### Using [bpkg](https://github.com/bpkg/bpkg)

```powershell
bpkg install -g DaFuqtor/wifi-pass
```

### Using Source Code

```powershell
git clone https://github.com/DaFuqtor/wifi-pass
cd wifi-pass
make
```

> Also allows to `make [ upgrade, uninstall ]`

## Usage

```powershell
wifi-pass [-hV] [options] [<ssid>]
          [-u,  --update]    # Check for update and ask to install
        # Options:
          [-c,  --copy]      # Copy the password to clipboard
          [-qr, --qrencode]  # Create QR-code for Wi-Fi connection
```

- SSID left empty means **current Wi-Fi network**

- Using **without options** just outputs password

  > To use `-qr`, you need [Homebrew](https://brew.sh/) to `brew install `[`qrencode`](https://fukuchi.org/works/qrencode/index.html.en) first