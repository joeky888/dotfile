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
RUN apk add --update --no-cache micro openssh-server

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
alias l="ls --color=auto -alh"            \n\
export PS1="\\\\u@\h \w# "                \n\
export LC_ALL="en_US.UTF-8"               \n\
export LANG="en_US.UTF-8"' > /root/.profile
RUN sed -i "s/\s*$//g" /root/.profile

#######################
#                     #
#     Environment     #
#                     #
#######################

ENV ENV="/root/.profile"
ENV EDITOR micro

SHELL ["/bin/ash"]
# ENTRYPOINT ["busybox", "ash"]
