rm -fr /var/www/html/apps/GharKaHisab/*
cp -r * /var/www/html/apps/GharKaHisab/
cp -r /home/latish/Documents/GharKaHisab_data /var/www/html/apps/GharKaHisab/
chown -R apache:apache /var/www/html/apps/GharKaHisab
