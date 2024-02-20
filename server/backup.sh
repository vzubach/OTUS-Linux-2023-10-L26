
yum install epel-release -y
yum install borgbackup -y
mkdir /var/backup
echo -e "n\np\n1\n\n\nw" | fdisk /dev/sda
mkfs.ext4 /dev/sda1
mount /dev/sda1 /var/backup
useradd -m borg
mkdir /home/borg/.ssh
cp /vagrant/client/id_rsa.pub /home/borg/.ssh/authorized_keys
chmod 700 /home/borg/.ssh
chmod 600 /home/borg/.ssh/authorized_keys
chown borg:borg /var/backup/
chown -R borg:borg /home/borg/
rm -rf /var/backup/*
sed -i 's/#PubkeyAuthentication/PubkeyAuthentication/p'  /etc/ssh/sshd_config
systemctl restart sshd.service






