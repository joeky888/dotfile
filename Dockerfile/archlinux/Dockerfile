FROM archimg/base:latest

################
#              #
# Update Repos #
#              #
################

RUN echo $'[archlinuxcn]\n\
SigLevel = Never\n\
Server = http://cdn.repo.archlinuxcn.org/$arch' >> /etc/pacman.conf
RUN pacman -Sy --noconfirm --needed curl pacman-contrib archlinuxcn-keyring nano powerpill
# Arch Linux Pacman Mirrorlist Generator
RUN mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
RUN bash -c "curl -fsSLk 'http://www.archlinux.org/mirrorlist/?country=CN&protocol=http&ip_version=4' > /etc/pacman.d/mirrorlist.bak"
RUN sed -i 's/^#S/S/' /etc/pacman.d/mirrorlist.bak
RUN cat /etc/pacman.d/mirrorlist.bak
RUN bash -c "rankmirrors -n 10 /etc/pacman.d/mirrorlist.bak | tee /etc/pacman.d/mirrorlist"

#####################
#                   #
# Install Softwares #
#                   #
#####################

# RUN pacman -S --noconfirm --needed powerpill
# RUN powerpill -Syyu --noconfirm --needed
# RUN pacman -S --noconfirm --needed nano powerpill
RUN bash -c "pacman -Qdtq | pacman -Rs - || echo ok"
RUN rm -rf /var/cache/pacman/pkg/*

#######################
#                     #
# Update /etc/profile #
#                     #
#######################

# TODO

#######################
#                     #
#     Environment     #
#                     #
#######################

ENV EDITOR nano

SHELL ["/bin/bash"]
