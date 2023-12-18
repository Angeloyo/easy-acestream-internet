echo "What is the IP of your server ?"

read serverip

# On a fresh ubuntu install:
# sudo apt update && sudo apt upgrade -y && sudo reboot

# Install requirements
sudo apt install snapd nginx -y

# Install acestream engine
sudo snap install acestreamplayer

#add configuration to nginx in order to bypass restriction of local IPs only from acestream
cp /etc/nginx/sites-available/default /etc/nginx/sites-available/old

rm /etc/nginx/sites-available/default

touch /etc/nginx/sites-available/default

echo "server {
    listen 80;
    listen [::]:80;
    server_name $serverip;

    location / {
        proxy_pass http://127.0.0.1:6878/;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $serverip:80;
        proxy_cache_bypass \$http_upgrade;

        proxy_set_header X-Real-IP 127.0.0.1;
        proxy_set_header X-Forwarded-For 127.0.0.1;
    }
}" >> /etc/nginx/sites-available/default

#apply changes
sudo systemctl reload nginx

# acestreamplayer.engine --live-cache-type memory --vod-cache-type memory --client-console

# Now open HLS streams as such:
# http://SERVERIP/ace/manifest.m3u8?id=STREAMID