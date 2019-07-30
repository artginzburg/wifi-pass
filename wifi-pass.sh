#!/usr/bin/env sh

VERSION=0.2

usage() {
  cat <<EOF

  Usage: wifi-pass [-hV] [options] <ssid>
    <ssid> left empty means current Wi-Fi network
    using without options just outputs password

  Options:
    -c, --copy       Copy the password to clipboard
    -qr, --qrencode  Create QR-code for Wi-Fi connection
    -V, --version    Output version
    -h, --help       This message.

EOF
}

copy=
qr=

wifi-pass() {
  for opt in "${@}"; do
    case "$opt" in
      -h|--help)
        usage
        return 0
        ;;
      -V|--version)
        echo "$VERSION"
        return 0
        ;;
      -c|--copy)
				copy=1
				;;
			-qr|--qrencode)
				qr=1
				;;
			*)
				if ! [ "$name" ]; then
					name="$opt"
				else
					name="$name $opt"
				fi
    esac
  done

  ssid=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}')

  if ! [ "$name" ]; then
  	name="$ssid"
  fi

  echo "\033[90m Keychain prompt --> \c"

	if [ "$copy" ]; then
		echo "Copy password\c"
	fi
	if [ "$qr" ] && [ "$copy" ]; then
		echo ", \c"
	fi
	if [ "$qr" ]; then
		echo "QR encode Wi-Fi connection\c"
	fi
	if ! ([ "$qr" ] || [ "$copy" ]); then
		echo "Get password\c"
	fi

	echo " for \"$name\". \033[39m"

  pass=`security find-generic-password -D 'AirPort network password' -a "$name" -gw || exit "$?"`

	case "$?" in
		"128")
			echo "\033[90m Cancelled getting password \033[39m"
			exit "$?"
			;;
		"44")
			echo "\033[90m Your Keychain hasn't any password for the requested SSID \033[39m"
			exit "$?"
			;;
	esac

	if [ "$pass" ]; then
	  if [ "$copy" ]; then
	    echo "$pass" | tr -d '\n' | pbcopy
	  fi

	  if [ "$qr" ]; then
	    qrencode -o ~/Desktop/$name.png -s 20 -m 3 "WIFI:S:$name;T:WPA;P:$pass;;"
	  fi

		if ! ([ "$qr" ] || [ "$copy" ]); then
			echo "$pass"
		fi
	else
		echo "\033[90m Unexpected error \033[39m"
		exit "$?"
	fi
}

if [[ ${BASH_SOURCE[0]} != $0 ]]; then
  export -f wifi-pass
else
  wifi-pass "${@}"
  exit $?
fi