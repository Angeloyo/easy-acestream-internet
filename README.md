# Easiest way to get Acestream over the Internet (HTTP)

This simple script installs acestream using snap, installs nginx and applies configuration that allows acestream to serve over the internet.

Recommended to use on a cloud VM, if you want to run in home server port forwarding is needed.

On a ubuntu machine, run the installation command:

    wget https://raw.githubusercontent.com/Angeloyo/easy-acestream-internet/main/install.sh -O /tmp/install.sh; bash /tmp/install.sh

Now you can start acestream:

    acestreamplayer.engine --client-console

If you want to store caché in RAM instead of disk:

    acestreamplayer.engine --live-cache-type memory --vod-cache-type memory --client-console

Now get the .m3u8 HLS stream as such:

    http://SERVERIP/ace/manifest.m3u8?id=STREAMID

