#!/usr/bin/env sh

VERSION=0.2.8
WP='wifi-pass'

usage() {
  cat <<EOF

  Usage: $WP [-hV] [options] [<ssid>]
    <ssid> left empty means current Wi-Fi network
    using without options just outputs password

  Options:
    -c,  --copy       Copy the password to clipboard
    -qr, --qrencode   Create QR-code for Wi-Fi connection
    -l,  --list       Search for stored networks
    -V,  --version    Output version
    -u,  --update     Check for update and ask to install
    -h,  --help       This message.

EOF
}

wifi_interface=$(networksetup -listallhardwareports | grep -A 1 Wi-Fi | grep Device | awk '{print $2}')

copy=
qr=

wifi_pass() {
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
      -u|--update)
        echo "$WP $VERSION"
        printf "  Checking for the update...\r"
        gitver=$(curl -s https://api.github.com/repos/DaFuqtor/$WP/releases/latest | grep tag_name | head -1 | awk -F: '{ print $2 }' | sed 's/[\",]//g' | tr -d '[:space:]')
        if [ "$gitver" = "$VERSION" ]; then
          echo "  Already up to date.       "
        else
          if [ "$gitver" ]; then
            echo "  Latest version is $gitver     "
            read -r -p "Do you want to update? [Enter/Ctrl+C]" response
            if [[ $response =~ ^( ) ]] || [[ -z $response ]]; then
              if command -v brew > /dev/null && brew list wifi-pass &> /dev/null; then
                 brew upgrade wifi-pass
              else
                echo "\n - Downloading latest $WP ($gitver)"
                curl -s $WP.ru | sh && echo " - Update completed!\n"
              fi
            else
              echo "  Enjoy the outdated $WP"
            fi
          else
            echo "  Couldn't check for update!"
            if [ "$(networksetup -getairportpower "$wifi_interface" | awk '{print $4}')" = "Off" ]; then
              read -r -p "Wi-Fi Adapter is disabled. Maybe you should consider turning it on? [Enter/Ctrl+C]" response
              if [[ $response =~ ^( ) ]] || [[ -z $response ]]; then
                networksetup -setairportpower "$wifi_interface" On && sleep 1 && wifi_pass "${@}"
              fi
            fi
            exit 1
          fi
        fi
        return 0
        ;;
      -l|--list)
        list=$(networksetup -listpreferredwirelessnetworks "$wifi_interface" | grep -v "Preferred networks on $wifi_interface")
        if [ "$2" ]; then
          search=$(echo "$@" | sed "s/-l //g")
        fi
        echo "$list" | grep "$search"
        return 0
        ;;
      -c|--copy)
        copy=1
        ;;
      -qr|--qrencode)
        if command -v qrencode > /dev/null; then
          qr=1
        else
          qr=
          echo 'Missing qrencode package'
          read -r -p "Do you want to 'brew install qrencode'? [Enter/Ctrl+C]" response
          if [[ $response =~ ^( ) ]] || [[ -z $response ]]; then
            if command -v brew > /dev/null; then
              echo "\n - Starting qrencode installation"
              brew install qrencode && echo " - [$WP] successfuly installed qrencode!\n" && qr=1
            else
              echo 'Missing Homebrew'
              read -r -p "Do you want to install it? [Enter/Ctrl+C]" response
              if [[ $response =~ ^( ) ]] || [[ -z $response ]]; then
                echo "\n - Starting Homebrew installation"
                /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && echo " - [$WP] successfuly installed Homebrew!\n" && wifi_pass "${@}"
              else
                echo "  Enjoy $WP without Homebrew qrencode package"
              fi
            fi
          else
            echo "  Enjoy $WP without qrencode"
          fi
        fi
        ;;
      *)
        if [ "$name" ]; then
          name="$name $opt"
        else
          name="$opt"
        fi
    esac
  done

  ssid=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}')

  if ! [ "$name" ]; then
    if [ "$ssid" ]; then
      name="$ssid"
    else
      echo "No SSID specified, can't grab it from current network"
      exit 1
    fi
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

  if security find-generic-password -D 'AirPort network password' -a "$name" &> /dev/null; then
    pass=$(security find-generic-password -D 'AirPort network password' -a "$name" -gw)
  else
    security find-generic-password -D 'AirPort network password' -a "$name" &> /dev/null
  fi

  case "$?" in
    128)
      echo "\033[90m Cancelled getting password \033[39m"
      exit 128
      ;;
    44)
      echo "\033[90m Your Keychain hasn't any password for the requested SSID \033[39m"
      exit 44
      ;;
  esac

  if [ "$pass" ]; then
    if [ "$copy" ]; then
      echo "$pass" | tr -d '\n' | pbcopy
    fi

    if [ "$qr" ]; then
      qrencode -o ~/Desktop/"$name".png -s 20 -m 3 "WIFI:S:$name;T:WPA;P:$pass;;"
    fi

    if ! ([ "$qr" ] || [ "$copy" ]); then
      echo "$pass"
    fi
  else
    echo "\033[90m Unexpected error \033[39m"
    exit 1
  fi
}

if [[ ${BASH_SOURCE[0]} != $0 ]]; then
  export -f wifi_pass
else
  wifi_pass "${@}"
  exit $?
fi