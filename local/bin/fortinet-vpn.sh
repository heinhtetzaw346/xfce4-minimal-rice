#!/usr/bin/env bash

VARS_FILE="$HOME/.fortinet-vpn-vars"
[ -f "$VARS_FILE" ] && . "$VARS_FILE" || { echo "Config not found! at $VARS_FILE"; exit 1; }

if [ "$1" = "--help" ]; then
    echo "You need to set the following required variables in $VARS_FILE
-> VPN_GATEWAY
-> VPN_GW_CERT_HASH
-> VPN_PORTAL_CERT_HASH
-> VPN_ICON"
    exit 0
fi

VPN_PID_FILE="/tmp/fortivpn.pid"
YAD_PID_FILE="/tmp/yad_forti.pid"

# --- DISCONNECT LOGIC ---
if [ -f "$VPN_PID_FILE" ] && ps -p $(cat "$VPN_PID_FILE") > /dev/null 2>&1; then
    echo "Disconnecting FortiVPN..."
    
    # 1. Kill the VPN (Root owned)
    sudo kill $(cat "$VPN_PID_FILE")
    sudo rm -f "$VPN_PID_FILE"

    # 2. Kill the YAD notification icon (User owned)
    if [ -f "$YAD_PID_FILE" ]; then
        kill $(cat "$YAD_PID_FILE") 2>/dev/null
        rm -f "$YAD_PID_FILE"
    fi
    
    echo "VPN Disconnected and UI cleaned up."
    notify-send -i "$VPN_ICON" -t 4000 "VPN Disconnected" "Tunnel to $VPN_GATEWAY disconnected"
    exit 0
fi

# --- CONNECT LOGIC ---
echo "Launching SAML Login for $VPN_USER..."
COOKIE=$(openfortivpn-webview "$VPN_GATEWAY" --trusted-cert="$VPN_PORTAL_CERT_HASH")

if [ -n "$COOKIE" ]; then
    # Start the VPN in the background
    sudo openconnect --protocol=fortinet \
        --servercert="$VPN_GW_CERT_HASH" \
        --cookie="$COOKIE" \
        --useragent="FortiClient" \
        --pid-file="$VPN_PID_FILE" \
        --background \
        "$VPN_GATEWAY"

    notify-send -i "$VPN_ICON" -t 4000 "VPN Connected" "Tunnel established to $VPN_GATEWAY"
    # Create the tray icon
    # Clicking the icon runs this script again ($0), triggering the Disconnect logic above
    yad --notification \
        --image="$VPN_ICON" \
        --text="FortiVPN: Connected to $VPN_GATEWAY" \
        --command="$0" & 

    # Save YAD's PID so we can kill the icon later
    echo $! > "$YAD_PID_FILE"
    echo "VPN Tunnel established. To $VPN_GATEWAY"
else
    echo "Login failed or cancelled."
    notify-send -u critical -i "dialog-error" "VPN Login Failed" "No authentication cookie received."
    exit 1
fi
