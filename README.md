Problemas:
Se ha generado una clave y se ha adjuntado a la imagen por comodidad pero no es una buena práctica
nfs: No funciona nfs en mac
nfs: he tenido que desplegar en un linux remoto
nfs: hace falta habilitar drivers por tanto tocó poner lo del caps (que está en el docker compose yml)
nfs: hace falta montar el volumen persistente en /srv
sudo modprobe nfs
sudo modprobe nfsd

Se prueba la posibilidad de montar un servidor sshfs en lugar de nfs, da problemas con docker y parece que en ciertas circunstancias parece más eficiente:
https://blog.ja-ke.tech/2019/08/27/nas-performance-sshfs-nfs-smb.html
