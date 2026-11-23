#!/bin/sh
set -e
UUID="${UUID:?UUID env is required}"
PORT="${PORT:-8080}"
WS_PATH="${WS_PATH:-/ws}"
mkdir -p /etc/xray
cat > /etc/xray/config.json <<EOF
{"log":{"loglevel":"warning"},"inbounds":[{"listen":"0.0.0.0","port":${PORT},"protocol":"vless","settings":{"clients":[{"id":"${UUID}","flow":""}],"decryption":"none"},"streamSettings":{"network":"ws","wsSettings":{"path":"${WS_PATH}"}}}],"outbounds":[{"protocol":"freedom"}]}
EOF
exec /usr/bin/xray run -config /etc/xray/config.json
