# Nginx

## Server config

```bash
sudo vim /etc/nginx/sites-available/[server_fqdn]
sudo vim /etc/nginx/sites-available/[server_fqdn]
```

## symbolic link ln

```bash
sudo ln -fs /etc/nginx/sites-available/[server_fqdn] /etc/nginx/sites-enabled/
```

## reload nginx

```bash
sudo service nginx reload
```

## Certificate/Certbot

```bash
sudo certbot
sudo certbot certificates
sudo certbot delete
sudo certbot -q renew --nginx ## crontab this
```

## Add user & password with basic auth .htpassword

```bash
sudo sh -c "echo -n 'oskar:' >> /etc/nginx/.htpasswd"
sudo sh -c "openssl passwd -apr1 >> /etc/nginx/.htpasswd"
```

## Serve files

```bash
location /reports {
alias /home/azureuser/public/reports/;
include /etc/nginx/mime.types;
}

location /dailybuild {
alias /opt/snowstorm/NO/SNOMEDCT-NO/;
autoindex on;
index     index.html index.htm index.php;
auth_basic "Dailybuild";
auth_basic_user_file /etc/nginx/.htpasswd;
}
```

## Edit mime:

```bash
sudo vim /etc/nginx/mime.types
    text/csv csv;
```

## SI Nginx config, example:

```bash
location /snowstorm/snomed-ct {
    proxy_pass http://localhost:8080;
    auth_request /auth;
    auth_request_set $auth_username $upstream_http_x_auth_username;
    auth_request_set $auth_roles $upstream_http_x_auth_roles;
    proxy_set_header Host $host;
    proxy_set_header X-Forwarded-Host $host;
    proxy_set_header X-AUTH-username $auth_username; # Special service they use
    proxy_set_header X-AUTH-roles $auth_roles;
    proxy_set_header X-AUTH-token $ihtsdo_cookie;

    location ~ .*/exports/.*/archive$ {
      rewrite ^(.$) $1;
      proxy_pass http://localhost:8080;
      proxy_send_timeout 10000;
      proxy_read_timeout 10000;
    }

    location ~ .*/browser/.*/validate/concepts$ {
      rewrite ^(.$) $1;
      proxy_pass http://localhost:8080;
      proxy_send_timeout 10000;
      proxy_read_timeout 10000;
    }

    location ~ .*/integrity-check$ {
      rewrite ^(.$) $1;
      proxy_pass http://localhost:8080;
      proxy_send_timeout 10m;
      proxy_read_timeout 10m;
    }

    location ~ .*/integrity-check-full$ {
      rewrite ^(.$) $1;
      proxy_pass http://localhost:8080;
      proxy_send_timeout 10m;
      proxy_read_timeout 10m;
    }
}
```
