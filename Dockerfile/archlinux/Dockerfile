FROM archimg/base:latest

################
#              #
# Update Repos #
#              #
################

RUN echo $'[archlinuxcn]\n\
SigLevel = Never\n\
Server = https://cdn.repo.archlinuxcn.org/$arch' >> /etc/pacman.conf

#####################
#                   #
# Install Softwares #
#                   #
#####################

RUN pacman -Syy
RUN pacman -S --noconfirm --needed archlinuxcn-keyring
RUN pacman -S --noconfirm --needed powerpill
RUN powerpill -Syyu --noconfirm --needed
RUN bash -c "pacman -Qdtq | pacman -Rs - || echo ok"
RUN powerpill -S --noconfirm --needed nano
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
