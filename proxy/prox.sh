prox() {
    main() {
        if [[ "$1" == "none" ]]; then
            echo -e "Reverting proxy\n"
            revertProxy
        elif [[ "$1" == "new" && -n "$2" ]]; then
            new_config_file="$HOME/$2.properties"
            if [[ ! -f "$new_config_file" ]]; then
                echo "port=" > "$new_config_file"
                echo "certificate-path=" >> "$new_config_file"
                echo "New properties file '$new_config_file' created."
                # Determine default editor
                if [[ -n "$EDITOR" ]]; then
                    exec "$EDITOR" "$new_config_file"
                else
                    # Fallback to nano if EDITOR is not set
                    exec nano "$new_config_file"
                fi
            else
                echo "Error: The file '$new_config_file' already exists."
            fi
        elif [[ -n "$1" ]]; then
            config_file="$HOME/$1.properties"
            ip=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | head -n 1)
            if [[ -f "$config_file" ]]; then
                port=$(grep '^port=' "$config_file" | cut -d= -f2)
                proxyCert=$(grep '^certificate-path=' "$config_file" | cut -d= -f2)

                if [[ "$2" == "-i" ]]; then
                    if [[ -n "$proxyCert" ]]; then
                        echo -e "Installing certificate \033[1;4m$(basename "$proxyCert")\033[0m and enabling proxy on port \033[1;4m$port\033[0m"
                        installCertificate
                    else
                        echo "Error: Certificate path not specified in the configuration file."
                        return 1
                    fi
                else
                    echo -e "Enabling proxy on port \033[1;4m$port\033[0m\n"
                    overrideProxy
                fi
            else
                echo "Error: The file $config_file doesn't exist. Run 'prox new $1' to initialize an empty file."
            fi
        else
            echo "Usage: prox [none | <config> [-i] | new <config>]"
            echo ""
            echo "Description:"
            echo "  Enables or disables proxy settings on the current device using configuration files. The configuration" 
            echo "  files specify proxy details such as port and SSL certificate path. Additionally, SSL certificates can"
            echo "  be installed for use with emulators."
            echo ""
            echo "Commands:"
            echo "  none                Disables the proxy on the current device."
            echo "  <config>            Enables the proxy on the current device using the configuration from the file"
            echo "                      named <config>.properties. Use the -i option to install SSL certificate."
            echo "  new <config>        Creates a new properties file named <config>.properties."
            echo ""
            echo "Options:"
            echo "  -i                  Installs the SSL certificate on the device, necessary for emulators."
            echo ""
            echo "Examples:"
            echo "  prox none           Disables the proxy settings."
            echo "  prox my_config      Enables the proxy settings using the configuration in my_config.properties."
            echo "  prox my_config -i   Enables the proxy settings and installs the SSL certificate specified"
            echo "                      in my_config.properties."
            echo "  prox new my_config  Creates a new configuration file named my_config.properties."
            echo ""
            echo "IMPORTANT: Disable the proxy when you're finished. Otherwise, the network connection on the device may"
            echo "not work properly."
        fi
    }

    checkADBCommand() {        
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
    }

    checkDeviceStatus() {
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
        else
            echo "❌ [ERROR] $states"
            echo "Please try to run the script again!"
            exit
        fi
    }

    overrideProxy() {
        checkADBCommand
        checkDeviceStatus

        echo "2. Override HTTP Proxy to ($ip:$port)..."
        for device in `adb devices | awk '{print $1}'`; do
        if [ ! "$device" = "" ] && [ ! "$device" = "List" ]
        then
            echo "🤖 Emulator ID = $device"
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

    installCertificate() {
        checkADBCommand
        checkDeviceStatus

        subjectHash=`openssl x509 -inform PEM -subject_hash_old -in $proxyCert | head -n 1`
        openssl x509 -in $proxyCert -inform PEM -outform DER -out $subjectHash.0

        # Iterate all emulators
        # Support using adb on multiple device at once
        for device in `adb devices | awk '{print $1}'`; do
        if [ ! "$device" = "" ] && [ ! "$device" = "List" ]
        then
            echo "🤖 Emulator ID = $device"
            echo "3. Start rooting the current emulator..."
            deviceStatus=$(adb -s $device root 2>&1)

            if [[ $deviceStatus == "adbd cannot run as root in production builds" ]]; then
                echo $deviceStatus
                echo "❌ [ERROR] Could not root your Android Emulator!!!"
                echo "Please make sure you're using Android Emulators with Google APIs (Android Emulator with Play Store is not supported)"
                exit
            fi

            echo "4. Waiting for restart... (5 seconds)"
            sleep 5

            echo "5. Install the Certificate"
            adb -s $device push ./$subjectHash.0 /data/misc/user/0/cacerts-added/$subjectHash.0
            adb -s $device shell "su 0 chmod 644 /data/misc/user/0/cacerts-added/$subjectHash.0"

            echo "6. Override HTTP Proxy to ($ip:$port)..."
            adb -s $device shell svc wifi enable
            adb -s $device shell settings put global http_proxy $ip:$port
        

            # Close all current app, to take effect
            echo "7. Close all current running apps..."
            APPS=$(adb -s $device shell dumpsys window a | grep "/" | cut -d "{" -f2 | cut -d "/" -f1 | cut -d " " -f2)
            for APP in $APPS ; do
                adb -s $device shell am force-stop $APP
            done
        fi
        done

        echo ""
        echo "Status: SUCCESS!"
        echo ""
        echo "Please restart your app from Android Studio to take effect"
        echo "Root Certificate is installed and trusted in Setting app -> Security -> Encryption & Credentials -> Trusted Certificate -> User Tab"

        # Remove temporary file
        rm ./$subjectHash.0
    }

    revertProxy() {
        checkADBCommand
        checkDeviceStatusFunc

        echo "2. Revert HTTP Proxy..."
        for device in `adb devices | awk '{print $1}'`; do
            if [ ! "$device" = "" ] && [ ! "$device" = "List" ]
            then
                echo "🤖 Emulator ID = $device"
                adb -s $device shell settings put global http_proxy :0
                if [ $? -eq 0 ]; then
                    echo "Status: SUCCESS!"
                else
                    echo "Could not revert proxy for Emulator ID = $device"
                fi
            fi
        done
    }

    main "$@"
}
