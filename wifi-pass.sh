#!/usr/bin/env sh

version="0.1.0"

usage() {
  cat <<EOF

  Usage: wifi-pass [option] [ssid]
    [ssid] left empty means current Wi-Fi network
    using without options just outputs password

  Options:
    -c, --copy       Copy the password to clipboard
    -qr, --qrencode  Create QR-code for Wi-Fi connection
    -V, --version    Output version
    -h, --help       This message.

EOF
}

ssid=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}')
if [ "$1" != "" ]; then
	case $1 in
	  -c | --copy )
	    if [ "$2" != "" ]; then
	    	echo "\033[90m Keychain prompt --> Copy password for \"$2\". \033[39m"
	      $0 $2 | tr -d '\n' | pbcopy
	    else
	      $0 -c $ssid
	    fi
	  	;;
	  -qr | --qrencode )
	    if [ "$2" != "" ]; then
	    	echo "\033[90m Keychain prompt --> QR encode Wi-Fi connection for \"$2\". \033[39m"
	      qrencode -o ~/Desktop/$2.png -s 20 -m 3 "WIFI:S:$2;T:WPA;P:$($0 $2);;"
	    else
	      $0 -qr $ssid
	    fi
	  	;;
	  -V | --version )
			echo $version
      exit
      ;;
    -h | --help )
      usage
      exit
      ;;
	  * )
	    # echo "\033[90m Keychain prompt --> Get password for \"$1\". \033[39m"
	    security find-generic-password -D "AirPort network password" -a "$1" -gw
	esac
else
	$0 $ssid
fi
