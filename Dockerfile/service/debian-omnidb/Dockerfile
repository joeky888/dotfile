FROM debian:testing

################
#              #
# Update Repos #
#              #
################

RUN echo "deb http://cdn-fastly.deb.debian.org/debian/ testing main contrib non-free" > /etc/apt/sources.list
RUN apt update
RUN apt install -y curl git vim gnupg locales tzdata python3-pip
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment; \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen; \
    echo "LANG=en_US.UTF-8" > /etc/locale.conf; \
    locale-gen en_US.UTF-8
ENV TZ Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

##################
#                #
#     Service    #
#                #
##################

RUN git clone --depth 1 https://github.com/OmniDB/OmniDB /OmniDB
WORKDIR /OmniDB
RUN pip3 install -r requirements.txt

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
alias ll="ls --color=auto -alh"           \n\
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
export PS1="╭─${BRed}\u@\h ${BGre}\w${BWhi} \n╰─# " \n\
export LC_ALL="en_US.UTF-8"               \n\
export LANG="en_US.UTF-8"' > /root/.bashrc
RUN sed -i "s/\s*$//g" /root/.bashrc

#######################
#                     #
#     Environment     #
#                     #
#######################

EXPOSE 8000/tcp 25482/tcp
ENTRYPOINT ["python3", "/OmniDB/OmniDB/omnidb-server.py", "--host=0.0.0.0", "--port=8000"]
ENV ENV="/root/.profile"
ENV EDITOR vim

SHELL ["/bin/bash"]

# docker-compose up -d --build
# docker exec -it omnidb /bin/bash
# Open http://localhost:8000 User:admin Password:admin
