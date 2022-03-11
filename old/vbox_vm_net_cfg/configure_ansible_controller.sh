echo "# This is the network config written by 'subiquity'
      network:
        ethernets:
          enp0s3:
            dhcp4: no
            addresses:
             - 192.168.1.110/24
            gateway4: 192.168.1.1
            nameservers:
              addresses: [8.8.8.8, 1.1.1.1]
          enp0s8:
            dhcp4: no
            addresses:
             - 10.10.10.10/24
        version: 2" > /etc/netplan/00-installer-config.yaml;

netplan apply;
# === Commands from here won't be executed if network changed

sed -i '/.local/d' /etc/hosts

hostname localhost

echo '127.0.0.1 localhost' > /etc/hosts
echo '127.0.0.1 controller.local' >> /etc/hosts
echo '10.10.10.10 controller.local' >> /etc/hosts
echo '10.10.10.20 master.local' >> /etc/hosts
echo '10.10.10.30 worker1.local' >> /etc/hosts
echo '10.10.10.40 nfs.local' >> /etc/hosts

hostname controller.local

echo 'controller.local' > /etc/hostname

apt-get install virtualbox-guest-additions-iso











# Como ansible
ssh-copy-id -i /home/ansible/.ssh/id_rsa.pub ansible@master.local
ssh-copy-id -i /home/ansible/.ssh/id_rsa.pub ansible@worker1.local
ssh-copy-id -i /home/ansible/.ssh/id_rsa.pub ansible@nfs.local
