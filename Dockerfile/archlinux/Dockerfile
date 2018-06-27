FROM archimg/base:latest

################
#              #
# Update Repos #
#              #
################

RUN echo $'[archlinuxcn]\n\
SigLevel = Never\n\
Server = https://cdn.repo.archlinuxcn.org/$arch' >> /etc/pacman.conf

RUN cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup

#####################
#                   #
# Install Softwares #
#                   #
#####################

RUN pacman -Sy --noconfirm --needed pacman-contrib archlinuxcn-keyring
RUN sed -i 's/^#S/S/g' /etc/pacman.d/mirrorlist
RUN bash -c "rankmirrors -n 10 /etc/pacman.d/mirrorlist.backup | tee /etc/pacman.d/mirrorlist"
# RUN pacman -S --noconfirm --needed powerpill
# RUN powerpill -Syyu --noconfirm --needed
RUN pacman -S --noconfirm --needed nano
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
