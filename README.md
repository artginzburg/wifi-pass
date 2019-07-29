# wifi-pass
 Bash tool to QR encode, copy or just get the password of current Wi-Fi connection

## Install

### Using [bpkg](https://github.com/bpkg/bpkg)

```
bpkg install -g DaFuqtor/wifi-pass
```

### Using `curl`

```
curl -L https://raw.github.com/DaFuqtor/wifi-pass/master/wifi-pass.sh -o /usr/local/bin/wifi-pass && chmod +x /usr/local/bin/wifi-pass
```

### Using Source Code

```
git clone https://github.com/DaFuqtor/wifi-pass.git
cd wifi-pass
make install
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