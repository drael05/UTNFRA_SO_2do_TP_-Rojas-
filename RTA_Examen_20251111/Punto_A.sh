sudo pvcreate /dev/sdb /dev/sdc
sudo vgcreate vg_datos /dev/sdb /dev/sdc
sudo lvcreate -L 5M -n lv_docker vg_datos
sudo lvcreate -L 1.5G -n lv_workareas vg_datos
sudo lvcreate -L 512M -n lv_swap vg_datos
sudo mkfs.ext4 /dev/vg_datos/lv_docker

diegg@Dieggo MINGW64 ~/Desktop/Arquitectura y siistemas operativos/Repositorio/UTN-FRA_SO_Vagrant/VagrantFiles/1_equipo_con_mas_discos (master)
$ vagrant up
==> vagrant: You have enabled the experimental flag with all features enabled.
==> vagrant: Please use with caution, as some of the features may not be fully
==> vagrant: functional yet.
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Checking if box 'ubuntu/jammy64' version '20241002.0.0' is up to date...
==> default: Machine already provisioned. Run `vagrant provision` or use the `--provision`
==> default: flag to force provisioning. Provisioners marked to run always will still run.

diegg@Dieggo MINGW64 ~/Desktop/Arquitectura y siistemas operativos/Repositorio/UTN-FRA_SO_Vagrant/VagrantFiles/1_equipo_con_mas_discos (master)
$ vagrant ssh
==> vagrant: You have enabled the experimental flag with all features enabled.
==> vagrant: Please use with caution, as some of the features may not be fully
==> vagrant: functional yet.
Welcome to Ubuntu 22.04.5 LTS (GNU/Linux 5.15.0-144-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Tue Nov 11 05:10:43 UTC 2025

  System load:  0.32              Processes:               100
  Usage of /:   3.9% of 38.70GB   Users logged in:         0
  Memory usage: 10%               IPv4 address for enp0s3: 10.0.2.15
  Swap usage:   0%


Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


The list of available updates is more than a week old.
To check for new updates run: sudo apt update
New release '24.04.3 LTS' available.
Run 'do-release-upgrade' to upgrade to it.


Last login: Tue Nov 11 04:25:52 2025 from 10.0.2.2
vagrant@ubuntu-jammy:~$ sudo adduser dieggo
adduser: The user `dieggo' already exists.
vagrant@ubuntu-jammy:~$ sudo usermod -aG sudo dieggo
vagrant@ubuntu-jammy:~$ su - dieggo
Password:
dieggo@ubuntu-jammy:~$ git clone https://github.com/upszot/UTN-FRA_SO_Examenes.git
fatal: destination path 'UTN-FRA_SO_Examenes' already exists and is not an empty directory.
dieggo@ubuntu-jammy:~$ ls -l
total 8
drwxrwxr-x  2 dieggo dieggo 4096 Nov 11 04:07 RTA_Examen_20251111
drwxrwxr-x 16 dieggo dieggo 4096 Nov 11 03:57 UTN-FRA_SO_Examenes
dieggo@ubuntu-jammy:~$ cd UTN-FRA_SO_Examenes/202406
dieggo@ubuntu-jammy:~/UTN-FRA_SO_Examenes/202406$ bash script_Precondicion.sh
mkdir: cannot create directory ‘/home/dieggo/RTA_Examen_20251111’: File exists
chmod: changing permissions of '/home/dieggo/.bash_history': Operation not permitted
[sudo] password for dieggo:
1Sorry, try again.
[sudo] password for dieggo:
Sorry, try again.
[sudo] password for dieggo:

Por favor ejecute: source  ~/.bashrc  && history -a

dieggo@ubuntu-jammy:~/UTN-FRA_SO_Examenes/202406$ ./script_Precondicion.sh
mkdir: cannot create directory ‘/home/dieggo/RTA_Examen_20251111’: File exists
chmod: changing permissions of '/home/dieggo/.bash_history': Operation not permitted

Por favor ejecute: source  ~/.bashrc  && history -a

dieggo@ubuntu-jammy:~/UTN-FRA_SO_Examenes/202406$ source ~/.bashrc
dieggo@ubuntu-jammy:~/UTN-FRA_SO_Examenes/202406$ ansible --version
Command 'ansible' not found, but can be installed with:
sudo apt install ansible-core  # version 2.12.0-1ubuntu0.1, or
sudo apt install ansible       # version 2.10.7+merged+base+2.10.8+dfsg-1
dieggo@ubuntu-jammy:~/UTN-FRA_SO_Examenes/202406$ sudo apt install wget gpg
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
gpg is already the newest version (2.2.27-3ubuntu2.4).
wget is already the newest version (1.21.2-2ubuntu1.1).
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
dieggo@ubuntu-jammy:~/UTN-FRA_SO_Examenes/202406$ ansible --version
Command 'ansible' not found, but can be installed with:
sudo apt install ansible-core  # version 2.12.0-1ubuntu0.1, or
sudo apt install ansible       # version 2.10.7+merged+base+2.10.8+dfsg-1
dieggo@ubuntu-jammy:~/UTN-FRA_SO_Examenes/202406$ cat > ~/RTA_Examen_20251111/Punto_A.sh << 'EOF'
> sudo pvcreate /dev/sdb /dev/sdc
> sudo vgcreate vg_datos /dev/sdb /dev/sdc
> sudo lvcreate -L 5M -n lv_docker vg_datos
> sudo lvcreate -L 1.5G -n lv_workareas vg_datos
> cat > ~/RTA_Examen_20251111/Punto_A.sh << 'EOF'
sudo pvcreate /dev/sdb /dev/sdc
sudo vgcreate vg_datos /dev/sdb /dev/sdc
sudo lvcreate -L 5M -n lv_docker vg_datos
sudo lvcreate -L 1.5G -n lv_workareas vg_datos
sudo lvcreate -L 512M -n lv_swap vg_datos
> sudo mkfs.ext4 /dev/vg_datos/lv_docker
>

sudo mkfs.ext4 /dev/vg_datos/lv_workareas
sudo mkswap /dev/vg_datos/lv_swap
sudo mkdir -p /var/lib/docker /work
sudo mount /dev/vg_datos/lv_docker /var/lib/docker
sudo mount /dev/vg_datos/lv_workareas /work
sudo swapon /dev/vg_datos/lv_swap
echo "/dev/vg_datos/lv_docker /var/lib/docker ext4 defaults 0 0" | sudo tee -a /etc/fstab
echo "/dev/vg_datos/lv_workareas /work ext4 defaults 0 0" | sudo tee -a /etc/fstab
echo "/dev/vg_datos/lv_swap none swap sw 0 0" | sudo tee -a /etc/fstab
sudo systemctl stop docker 2>/dev/null
sudo systemctl start docker 2>/dev/null
