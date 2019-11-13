# telegram-middleman-bot

[![Say thanks](https://img.shields.io/badge/SayThanks.io-%E2%98%BC-1EAEDB.svg)](https://saythanks.io/to/n1try)

![](http://i.imgur.com/lvshgaj.png)

__I'm the [@MiddleMan](https://telegram.me/MiddleManBot) bot! I sit in the middle between whatever you want to send yourself as a message and your Telegram.__

I translate simple JSON HTTP requests into Telegram push messages that you will get on your Smartphone, PC or whatever Telegram client you have.

[![Buy me a coffee](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://buymeacoff.ee/n1try)

## What's new (2019-11-06) ?
Thanks to contributions by [peet1993](https://github.com/peet1993).

* Introduced explicit IPv6 support 
* Introduced ability to specify network address to bind to

## Why might this be useful?
This is especially useful for __developers or sysadmins__. Imagine you want some kind of reporting from your application or server, like a daily report including some statistics. You don't want to actively look it up on a website but you want to receive it in a __passive fashion__. Just like getting an e-mail. But come on, let's be honest. __E-Mails are so 2010__. And they require your little server-side script to include some SMTP library and connect to a mail server. That's __too heavyweight__ just to __get some short information__. Personally, I have a Python script running on my server which gathers some statistics from log files and databases and regularly sends me a Telegram message.

If you develop those thoughts further, this could potentially __replace any kind of e-mail notifications__ - be it the message that someone has answered to your __forum post__, your favorite game is __now on sale at Steam__, and so on. It's __lightweight and easy__, unlike e-mails that have way too much overhead.

## How to run it?
You can either set up your own instance or use mine, which is running at [https://apps.muetsch.io/middleman](https://apps.muetsch.io/middleman). The hosted instance only allows for a maxmimum of 240 requests per recipient per day. If you want to set this up on your own, do the following. You can either run the bot in long-polling- or webhook mode. For production use the latter option is recommended for [various reasons](https://core.telegram.org/bots/webhooks). However, you'll need a server with a static IP and s (self-signed) SSL certificate. 
1. Make sure u have the latest version of Go installed.
2. `go get github.com/n1try/telegram-middleman-bot`
3. `cd <YOUR_GO_WORKSPACE_PATH>/src/github.com/n1try/telegram-middleman-bot`
4. `go get ./...`
5. `go build .`

### Using long-polling mode
1. `./telegram-middleman-bot --token <TOKEN_YOU_GOT_FROM_BOTFATHER> --port 8080` (of course you can use a different port)

### Using webhook mode 
1. If you don't have an official, verified certificate, create one doing `openssl req -newkey rsa:2048 -sha256 -nodes -keyout middleman.key -x509 -days 365 -out middleman.pem` (the CN must match your server's IP address)
2. Tell Telegram to use webhooks to send updates to your bot. `curl -F "url=https://<YOUR_DOMAIN_OR_IP>/api/updates" -F "certificate=@<YOUR_CERTS_PATH>.pem" https://api.telegram.org/bot<TOKEN_YOU_GOT_FROM_BOTFATHER>/setWebhook`
3. `./telegram-middleman-bot --token <TOKEN_YOU_GOT_FROM_BOTFATHER> --mode webhook --certPath middleman.pem --keyPath middleman.key --port 8443 --useHttps` (of course you can use a different port)

Alternatively, you can also use a __reverse proxy__ like _nginx_ or [_Caddy_](https://caddyserver.com) to handle encryption. In that case you would set the `mode` to _webhook_, but `useHttps` to _false_ and your bot wouldn't need any certificate.

### Additional parameters
* `--address` (`string`) – Network address (IPv4) to bind to. Default to `127.0.0.1`.
* `--address6` (`string`) – Network address (IPv6) to bind to. Default to `::1`.
* `--disableIPv6` (`bool`) – Whether or not to disable listening on both IPv4 and IPv6 interfaces. Default to `false`.
* `--proxy` (`string`) – Proxy connection string to be used for long-polling mode. Defaults to none.
* `--rateLimit` (`int`) – Maximum number of messages to be delivered to each recipient per hour. Defaults to `10`.

## How to use it?
1. You need to get a token from the bot. Send a message with `/start` to the [@MiddleManBot](https://telegram.me/MiddleManBot) therefore.
2. Now you can use that token to make HTTP POST requests to `http://localhost:8080/api/messages` (replace localhost by the hostname of your server running the bot or mine as shown above) with a body that looks like this.

```
{
	"recipient_token": "3edf633a-eab0-45ea-9721-16c07bb8f245",
	"text": "*Hello World!* (yes, this is Markdown)",
	"type": "TEXT",
	"origin": "My lonely server script"
}
```

**NOTE:** If the field *type* is omitted then the `TEXT` type will be used as default, though this is not recommended as this may change in future versions.

3. If you want to **attach a file** in the HTTP POST request you need to encode it to a Base64 string and send it in the body as follows.

```
{
	"recipient_token": "3edf633a-eab0-45ea-9721-16c07bb8f245",
	"file": "SGVsbG8gV29ybGQhCg==",
	"filename": "file.txt",
	"type": "FILE",
	"origin": "My lonely server script"
}
```

## License
MIT @ [Ferdinand Mütsch](https://muetsch.io)
