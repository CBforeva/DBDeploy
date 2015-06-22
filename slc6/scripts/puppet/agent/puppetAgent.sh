
echo " "
echo "##########################################"
echo "# WOOF -> Catalog run...                 #"
echo "##########################################"
HOSTNAME=$(hostname --fqdn)
MASTERNAME=puppet-master.cern.ch
puppet agent --server $MASTERNAME --certname $HOSTNAME --waitforcert 10 --test --no-daemonize --verbose

