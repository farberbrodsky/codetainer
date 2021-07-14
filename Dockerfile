FROM debian:sid

RUN apt-get -y update && apt-get -y upgrade

# Create user with dotfiles
RUN apt-get -y install sudo yadm
RUN echo "%wheel ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN useradd -s "/bin/bash" -m misha && groupadd wheel && usermod -a -G wheel misha
RUN sudo -u misha /bin/bash -c "cd /home/misha && rm .bashrc && yadm clone https://github.com/farberbrodsky/dotfiles"
RUN apt-get install -y curl wget

# SSH
RUN sudo -u misha /bin/bash -c "mkdir /home/misha/.ssh && touch /home/misha/.ssh/authorized_keys"
RUN sudo -u misha /bin/bash -c "curl https://github.com/farberbrodsky.keys > /home/misha/.ssh/authorized_keys"
RUN apt-get install -y openssh-server

# LS Deluxe
RUN /bin/bash -c "cd /home/misha; X=\$(sudo -u misha /home/misha/scripts/github_latest_release Peltoche/lsd); Y=\$(echo \$X | sed \"s/.*download\\///;s/\\///\"); echo X \$X Y \$Y; wget \${X}lsd_\${Y}_amd64.deb; apt-get install -y ./lsd*; rm ./lsd*"

# Starship shell prompt
RUN sudo -u misha /bin/bash -c "cd /home/misha && wget $(/home/misha/scripts/github_latest_release starship/starship)starship-x86_64-unknown-linux-gnu.tar.gz && tar -xvf starship* && mkdir -p .local/bin && mv starship .local/bin/ && rm starship*"

# Neovim
RUN apt-get install -y neovim npm
RUN sudo -u misha /bin/bash -c "curl -fLo /home/misha/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
RUN sudo -u misha /bin/bash -c "cd /home/misha && nvim +'PlugInstall' +qa --headless"

CMD /etc/init.d/ssh start & /bin/bash -c "while true; do sleep 999; done"
