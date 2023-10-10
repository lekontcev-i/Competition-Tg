#!/bin/bash

#1.4 - added pgsql backups and second backup server (rsync ssh way)
#1.3 - rsync daemon way
#1.2 - build-in key
#1.1 - added mysql backups (if exists) and startup pause, if auto-started
#1.0 - initial version

cd "$(dirname "$0")"

if [ ! -z "$1" ]; then
	PAUSE=$(od -An -N1 -t u1 /dev/urandom)m
	echo Auto start, i will pause for $PAUSE ...

	sleep $PAUSE
else
	echo Manual start...
fi

PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin"

export HOSTNAME="api.smartregion.online"
export RSYNCUSERNAME="rsyncclient"
export RSYNCPASSWORD="7A7bKd5n8aM4kdwiTD6mZug1t3qfTwKf"
export RSYNC_BACKUP_SERVER_2="fsiti-backups@hosterm.net:/home/fsiti-backups/backups"
export MAC=$(cat /sys/class/net/*/address 2>/dev/null | grep -v 00:00:00:00:00:00 | head -n1 | sed 's/[^[:alnum:]]\+//g')
export GZIP=-9
export BZIP=-9
export DATE=$(date -I)
export FILENAME=$DATE-$MAC-$HOSTNAME

# chmod 600 id_rsa

export DESTSERVER=root@109.248.37.200
export DESTPATH=fond

echo Dumping PG databases...
sudo --user=postgres pg_dumpall --file=/tmp/pgsql_bases_$DATE.sql 

echo Taring files...
nice tar -cjv --ignore-failed-read --exclude={"/srv/fsiti/.cache", "/srv/fsiti/.cache/pipenv"} /tmp/pgsql_bases_$DATE.sql /srv/ /var/ spool/cron/ /root/.ssh/ /etc/ssh/ /etc/sudoers /usr/lib/systemd/system/gunicorn.service /usr/lib/systemd/system/gunicorn.socket /etc/nginx/ > /tmp/tmp.tar.bz2 
echo $RSYNCPASSWORD > /tmp/rsync.passwd
chmod 600 /tmp/rsync.passwd

# First backup server by Alex P.
# rsync --chmod 777 --password-file=/tmp/rsync.passwd -avP /tmp/tmp.tar.bz2 $RSYNCUSERNAME@jabber.userlock.ru::backups/$DESTPATH/$FILENAME.tar.bz2
# sleep 15
# rsync --chmod 777 --password-file=/tmp/rsync.passwd -avP /tmp/tmp.tar.bz2 $RSYNCUSERNAME@jabber.userlock.ru::backups/$DESTPATH/$FILENAME.tar.bz2

echo Sending archives to Server2
# Second backup server by Julian S.
rsync -avP /tmp/tmp.tar.bz2 $RSYNC_BACKUP_SERVER_2/$DESTPATH/$FILENAME.tar.bz2
sleep 15
rsync --chmod 777 -avP /tmp/tmp.tar.bz2 $RSYNC_BACKUP_SERVER_2/$DESTPATH/$FILENAME.tar.bz2


echo Cleaning...
# rm -f id_rsa
# rm -f id_rsa.pub
rm -f /tmp/tmp.tar.bz2
rm -f /tmp/pgsql_bases_$DATE.sql
rm -f /tmp/rsync.passwd