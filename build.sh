mkdir -p src models data diagnostics


echo "XAUTHORITY=$XAUTHORITY"
echo "XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR"

export XAUTHORITY=$(xauth info | grep "Authority file" | awk '{print $3}')
export XDG_RUNTIME_DIR=/run/user/$(id -u)

xhost +local:docker
# Create .docker.xauth file
touch /tmp/.docker.xauth
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f /tmp/.docker.xauth nmerge -
chmod 777 /tmp/.docker.xauth


docker compose up -d
docker attach advantech-l2-02
