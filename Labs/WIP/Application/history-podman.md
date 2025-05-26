
podman --version
podman -h

podman machine init
podman machine start

podman system connection list

podman build .
podman build -t entreprise:latest .
podman build -t toto .

podman image list

podman run localhost/toto:latest

podman ps
podman ps -a
