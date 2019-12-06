FROM archlinux/base:latest

################
#              #
# Update Repos #
#              #
################

RUN echo $'[archlinuxcn]\n\
SigLevel = Never\n\
Server = http://cdn.repo.archlinuxcn.org/$arch' >> /etc/pacman.conf

# Mingw
# RUN echo $'[ownstuff]\n\
# SigLevel = Never\n\
# Server = https://martchus.no-ip.biz/repo/arch/ownstuff/os/$arch' >> /etc/pacman.conf

RUN pacman -Sy --noconfirm --needed sed gzip curl pacman-contrib archlinuxcn-keyring sudo vim yay bash-completion
# Arch Linux Pacman Mirrorlist Generator
RUN mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
RUN bash -c "curl -fsSLk 'http://www.archlinux.org/mirrorlist/?country=TW&protocol=http&ip_version=4' | tee /etc/pacman.d/mirrorlist.bak"
RUN sed -i 's/^#S/S/' /etc/pacman.d/mirrorlist.bak
RUN cat /etc/pacman.d/mirrorlist.bak
RUN bash -c "rankmirrors -n 10 /etc/pacman.d/mirrorlist.bak | tee /etc/pacman.d/mirrorlist"
ENV TZ Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#####################
#                   #
# Add sudoer joeky  #
#                   #
#####################

ENV USER joeky
RUN /usr/sbin/useradd $USER && \
    echo "$USER ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/user && \
    chmod 0440 /etc/sudoers.d/user
ENV HOME /home/$USER
RUN mkdir -p $HOME
RUN chown -R $USER:$USER $HOME

#####################
#                   #
# Install Softwares #
#                   #
#####################

RUN bash -c "pacman -Qdtq | pacman -Rs --noconfirm - || echo ok"
RUN pacman -Scc --noconfirm || echo ok

#######################
#                     #
# Update .bashrc file #
#                     #
#######################

RUN sed -i "s/^#en_US.UTF-8/en_US.UTF-8/" /etc/locale.gen && locale-gen en_US.UTF-8 && echo "LANG=en_US.UTF-8" > /etc/locale.conf

RUN echo $'export CHARSET=UTF-8           \n\
export PAGER=less                         \n\
umask 022                                 \n\
for script in /etc/profile.d/*.sh ; do    \n\
if [ -r \$script ] ; then                 \n\
  . \$script                              \n\
fi                                        \n\
done                                      \n\
alias ls="ls --color=auto"                \n\
alias ll="ls --color=auto -lh"            \n\
alias l="ls --color=auto -alh"            \n\
export Blk="\e[0;30m"                     \n\
export Red="\e[0;31m"                     \n\
export Gre="\e[0;32m"                     \n\
export Yel="\e[0;33m"                     \n\
export Blu="\e[0;34m"                     \n\
export Pur="\e[0;35m"                     \n\
export Cya="\e[0;36m"                     \n\
export Whi="\e[0;37m"                     \n\
export BBla="\e[1;30m"                    \n\
export BRed="\e[1;31m"                    \n\
export BGre="\e[1;32m"                    \n\
export BYel="\e[1;33m"                    \n\
export BBlu="\e[1;34m"                    \n\
export BPur="\e[1;35m"                    \n\
export BCya="\e[1;36m"                    \n\
export BWhi="\e[1;37m"                    \n\
export PS1="╭─${BCya}\\\\u@\h ${BGre}\w${BWhi} \n╰─\$ " \n\
export LC_ALL="en_US.UTF-8"               \n\
export LANG="en_US.UTF-8"' > $HOME/.bashrc
RUN sed -i "s/\s+$//g" $HOME/.bashrc

#######################
#                     #
#     Environment     #
#                     #
#######################

ENV EDITOR vim
USER $USER

SHELL ["/bin/bash"]

# docker build . -t arch:joeky
# docker run --name arch --net host -it arch:joeky bash
# docker cp ~/dotfile/app-fast/app-fast arch:/bin/
# docker cp ~/dotfile/.bashrc arch:/home/joeky/
# docker cp ~/dotfile/vimrc/.vimrc arch:/home/joeky/
