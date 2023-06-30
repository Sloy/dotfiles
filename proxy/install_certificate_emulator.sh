#!/bin/bash -eu
# Forked from Proxyman

mode=$1
port=$2
proxyCert=$3
ip=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | head -n 1)

echo ""
echo "---------------------------------------------------------------------"
echo "------ Install Certificate to Android Emulator Script ------"
echo "---------------------------------------------------------------------"
echo ""
echo "---------------------------------------------------------------------"
echo "Only Support with Android Emulators (Google APIs), not support for Google Play Store version!"
echo "Document at: https://docs.proxyman.io/debug-devices/android-device/automatic-script-for-android-emulator"
echo "---------------------------------------------------------------------"
echo ""

checkADBCommand() {
    echo "Checking adb command..."
    if ! command -v adb &> /dev/null
    then
        echo "❌ [ERROR] adb command line could not found!!!"
        echo "Please install adb from android-platform-tools"
        echo "Read more at: https://docs.proxyman.io/debug-devices/android-device/automatic-script-for-android-emulator#4-how-does-it-work"
        echo ""
        echo "You can install by running the following commands on the Terminal app:"
        echo "1. Install Homebrew (Skip if you've already installed):"
        echo ""
        echo "/bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)\""
        echo ""
        echo "2. Install adb command"
        echo ""
        echo "brew install android-platform-tools"
        echo ""
        echo "3. Try to run the script again!"
        exit
    fi
    echo "Found at: $(which adb)"
}

checkDeviceStatusFunc() {
    echo "1. Checking Android Emulators Status..."

    # Get error output
    # Use || true to prevent the script is exited
    states=$(adb get-state 2>&1 1>/dev/null) || true

    if [[ $states == "error: no devices/emulators found" ]]; then
        echo "❌ [ERROR] Could not find any active Android Emulators!!!"
        echo "Please start one Android Emulator from Android Studio then try again!"
        exit
    elif [[ $states == "error: more than one device/emulator" ]]; then
        echo "Found multiple Android Emulators!"
        # continue running, do not exit
    elif [[ $states == "error: device offline" ]]; then
        echo "❌ [ERROR] Device is offline."
        echo "Please restart your Android Emulator Device and try again!"
        exit
    elif [[ -z "$states" ]]; then
        echo "Status: OK!"
    else
        echo "❌ [ERROR] $states"
        echo "Please try to run the script again!"
        exit
    fi
}

installCertificateFunc() {

    ## Check adb
    checkADBCommand

    ## Check Status first
    checkDeviceStatusFunc

    echo "2. Prepare Proxy CA Certificate..."

    subjectHash=`openssl x509 -inform PEM -subject_hash_old -in $proxyCert | head -n 1`
    openssl x509 -in $proxyCert -inform PEM -outform DER -out $subjectHash.0

    # Iterate all emulators
    # Support using adb on multiple device at once
    for device in `adb devices | awk '{print $1}'`; do
      if [ ! "$device" = "" ] && [ ! "$device" = "List" ]
      then
        echo "====================================="
        echo "🤖 Emulator ID = $device"
        echo "====================================="
        echo "3. Start rooting the current emulator..."
        status=$(adb -s $device root 2>&1)

        if [[ $status == "adbd cannot run as root in production builds" ]]; then
            echo $status
            echo "❌ [ERROR] Could not root your Android Emulator!!!"
            echo "Please make sure you're using Android Emulators with Google APIs (Android Emulator with Play Store is not supported)"
            exit
        else
            echo "Root current Android Emulators success!"
        fi

        echo "4. Waiting for restart..."
        sleep 5

        echo "5. Install the Certificate to..."
        adb -s $device push ./$subjectHash.0 /data/misc/user/0/cacerts-added/$subjectHash.0
        adb -s $device shell "su 0 chmod 644 /data/misc/user/0/cacerts-added/$subjectHash.0"

        # Override Proxy if need
        if [[ $mode == "all" ]]; then
            echo "6. Override HTTP Proxy to ($ip:$port)..."
            adb -s $device shell svc wifi enable
            adb -s $device shell settings put global http_proxy $ip:$port
        fi

        # Close all current app, to take effect
        echo "7. Close all current running apps..."
        APPS=$(adb -s $device shell dumpsys window a | grep "/" | cut -d "{" -f2 | cut -d "/" -f1 | cut -d " " -f2)
        for APP in $APPS ; do
            echo "Closing: $APP"
            adb -s $device shell am force-stop $APP
        done
      fi
    done


    echo "Status: SUCCESS!"
    echo "Please restart your app from Android Studio to take effect"
    echo "Root Certificate is installed and trusted in Setting app -> Security -> Encryption & Credentials -> Trusted Certificate -> User Tab"

    # Remove temporary file
    rm ./$subjectHash.0
}

revertProxy() {

    ## Check adb
    checkADBCommand

    ## Check Status first
    checkDeviceStatusFunc

    echo "2. Revert HTTP Proxy..."
    for device in `adb devices | awk '{print $1}'`; do
        if [ ! "$device" = "" ] && [ ! "$device" = "List" ]
        then
            echo "====================================="
            echo "🤖 Emulator ID = $device"
            echo "====================================="
            adb -s $device shell settings put global http_proxy :0
            if [ $? -eq 0 ]; then
                echo "Status: SUCCESS!"
            else
                echo "Could not revert proxy for Emulator ID = $device"
            fi
        fi
    done
}

overrideProxy() {

    ## Check adb
    checkADBCommand

    ## Check Status first
    checkDeviceStatusFunc

    echo "2. Override HTTP Proxy to ($ip:$port)..."
    for device in `adb devices | awk '{print $1}'`; do
    if [ ! "$device" = "" ] && [ ! "$device" = "List" ]
    then
        echo "====================================="
        echo "🤖 Emulator ID = $device"
        echo "====================================="
        adb -s $device shell svc wifi enable
        adb -s $device shell settings put global http_proxy $ip:$port
        if [ $? -eq 0 ]; then
            echo "Status: SUCCESS!"
        else
            echo "Could not override proxy for Emulator ID = $device"
        fi
    fi
    done
}

# Main

if [[ $mode == "all" ]]; then
    installCertificateFunc
elif [[ $mode == "proxy" ]]; then
    overrideProxy
elif [[ $mode == "revertProxy" ]]; then
    revertProxy
fi