FROM alpine:edge

################
#              #
# Update Repos #
#              #
################

RUN echo "ipv6" >> /etc/modules
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/main/" > /etc/apk/repositories; \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/community/" >> /etc/apk/repositories; \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories

#####################
#                   #
# Install Softwares #
#                   #
#####################

RUN apk update
RUN apk add --upgrade --force apk-tools
RUN apk upgrade
RUN apk add --update --no-cache nano openrc
RUN rm -f /var/cache/apk/*

#######################
#                     #
# Update /etc/profile #
#                     #
#######################

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
export PS1="╭─${BRed}\\\\u@\h ${BGre}\w${BWhi} \n╰─# " \n\
export LC_ALL="en_US.UTF-8"               \n\
export LANG="en_US.UTF-8"' > /root/.profile
RUN sed -i "s/\s+$//g" /root/.profile

#######################
#                     #
#     Environment     #
#                     #
#######################

ENV ENV="/root/.profile"
ENV EDITOR nano

SHELL ["/bin/ash"]
# ENTRYPOINT ["busybox", "ash"]
