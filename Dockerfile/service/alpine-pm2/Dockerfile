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

RUN apk add --upgrade --no-cache --force apk-tools
RUN apk update
RUN apk upgrade
RUN apk add --update --no-cache nano nodejs-npm git
RUN npm install -g pm2
RUN rm -f /var/cache/apk/*

######################
#                    #
#       Service      #
#                    #
######################

WORKDIR /root
ADD . .
WORKDIR /root/node-data-controller
RUN npm install

##################################
#                                #
# Update /etc/profile (Optional) #
#                                #
##################################

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
export PS1="${BRed}\\\\u@\h ${BGre}\w${BWhi} \n# " \n\
export LC_ALL="en_US.UTF-8"               \n\
export LANG="en_US.UTF-8"' > /root/.profile
RUN sed -i "s/\s*$//g" /root/.profile

#######################
#                     #
#     Environment     #
#                     #
#######################

EXPOSE 8080 8080
WORKDIR /root/node-data-controller
ENTRYPOINT pm2-runtime start server.js
ENV ENV="/root/.profile"
ENV EDITOR nano
ENV USER root
ENV user root
ENV pm2_home /root/.pm2/

SHELL ["/bin/ash"]

# docker build . -t alpine:joeky
# docker run -d --name controller -p 8080:8080 --restart=always -it alpine:joeky /bin/sh
# docker exec -it controller /bin/sh
