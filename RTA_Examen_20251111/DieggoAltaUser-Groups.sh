USUARIO_REF="$1"
ARCHIVO="$2"
[ -z "$USUARIO_REF" ] || [ -z "$ARCHIVO" ] && { echo "Uso: $0 <ref> <archivo>"; exit 1; }
PASS=$(sudo grep "^$USUARIO_REF:" /etc/shadow | cut -d: -f2)
while IFS=: read -r user group; do
  getent group "$group" || sudo groupadd "$group"
  id "$user" &>/dev/null || {
    sudo useradd -m -g "$group" -s /bin/bash "$user"
    echo "$user:$PASS" | sudo chpasswd -e
  }
done < "$ARCHIVO"
