# codetainer
My docker container for writing code while keeping my computer clean

Run build.sh to build the container, create.sh to install it (and it will start automatically on boot), create_sync.sh to create it but let you press Ctrl-C to stop it, and connect.sh to SSH into the container. connect.sh requires get_codetainer_ip.service to be running, because this service find the IP of the container and saves it in /var/run/codetainer-ip.
