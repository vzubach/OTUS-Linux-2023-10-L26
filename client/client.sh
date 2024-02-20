
yum install epel-release -y
yum install borgbackup -y
cd ~
mkdir .ssh
cp /vagrant/client/id_r* .ssh/
cp /vagrant/client/borg-backup.* /etc/systemd/system/
chmod 700 .ssh
chmod 600 .ssh/id_rsa
ssh-keyscan -H 192.168.11.160 >> .ssh/known_hosts

export BORG_PASSPHRASE="123456789"
borg init --encryption=repokey borg@192.168.11.160:/var/backup/
borg create --stats borg@192.168.11.160:/var/backup::etc-{now:%%Y-%%m-%%d_%%H:%%M:%%S} /etc

systemctl start borg-backup.timer
systemctl start borg-backup.service
