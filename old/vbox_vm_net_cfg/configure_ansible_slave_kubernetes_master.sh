echo "# This is the network config written by 'subiquity'
      network:
        ethernets:
          enp0s3:
            dhcp4: no
            addresses:
             - 192.168.1.120/24
            gateway4: 192.168.1.1
            nameservers:
              addresses: [8.8.8.8, 1.1.1.1]
          enp0s8:
            dhcp4: no
            addresses:
             - 10.10.10.20/24
        version: 2" > /etc/netplan/00-installer-config.yaml;

netplan apply;
# === Commands from here won't be executed if network changed
