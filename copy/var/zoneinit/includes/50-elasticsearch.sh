# set nodename and enable service
HOSTNAME=$( hostname | tr "."  "\n" | sed -n 1p)
sed -i "s/#node.name: node-1/node.name: ${HOSTNAME}/" /opt/local/etc/elasticsearch/elasticsearch.yml

svcadm enable svc:/pkgsrc/elasticsearch:default
