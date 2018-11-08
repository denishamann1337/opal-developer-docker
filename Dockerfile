FROM ubuntu:18.04
MAINTAINER rarspace01@gmail.com

RUN apt-get update -y && apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y firefox wget software-properties-common openjdk-11-jdk gnome-shell

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    usermod -aG sudo developer && \
    chown ${uid}:${gid} -R /home/developer

WORKDIR /tmp
RUN wget -q 'https://download.jetbrains.com/idea/ideaIU-2018.2.5.tar.gz' && \
    tar xzf ideaIU-2018.2.5.tar.gz && rm ideaIU-2018.2.5.tar.gz && \
    mv idea-* /opt/idea && \
    ln -s /opt/idea/bin/idea.sh /usr/local/bin/idea.sh

WORKDIR /

USER developer
ENV HOME /home/developer
CMD /usr/local/bin/idea.sh