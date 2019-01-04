# Generate hostname for nginx config
HOST=$(hostname)
NGINX_HOME='/opt/local/etc/nginx'

# Config hostname in nginx config
gsed -i "s:__HOSTNAME__:${HOST}:g" \
	${NGINX_HOME}/nginx.conf

# create htpasswd file
if mdata-get nginx_htpasswd 1>/dev/null 2>&1; then
  user=$(mdata-get nginx_htpasswd | tr ":"  "\n" | sed -n 1p)
  pass=$(mdata-get nginx_htpasswd | tr ":"  "\n" | sed -n 2p)
  crypt=$(openssl passwd -apr1 $pass)
  echo "$user:$crypt" > /opt/local/etc/nginx/.htpasswd
  chown www:root /opt/local/etc/nginx/.htpasswd
  chmod 0640 /opt/local/etc/nginx/.htpasswd
fi

# Enable nginx
svcadm enable svc:/pkgsrc/nginx:default
