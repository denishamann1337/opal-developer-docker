FROM ubuntu:18.04
MAINTAINER rarspace01@github

RUN apt-get update -y && apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y firefox wget software-properties-common openjdk-11-jdk ubuntu-gnome-desktop geany htop openvpn easy-rsa \
	jq \
        python-pip \
        python3-pip \
        python-dev \
        python3-dev \
        ruby \
        ruby-dev \
        make \
        nethogs \
        htop \
        nano \
        sysstat \
        build-essential \
        python3-venv \
        zip \
        zlibc zlib1g zlib1g-dev \
        openssl libssl-dev \
        virtualenv \
        nodejs \
	xrdp \
 && rm -rf /var/lib/apt

RUN chown root:users /etc/xrdp/key.pem

RUN systemctl enable xrdp

#RUN
RUN pip install --upgrade pip setuptools wheel \
 && pip3 install --upgrade pip setuptools wheel \
 && python3.6 -m pip install --upgrade pip setuptools wheel \
 && python3.6 -m pip install --upgrade virtualenv


# install aws-cli
RUN pip3 install --upgrade \
        awscli \
        awslimitchecker \
        boto3

# install bundler
RUN gem install \
    bundler

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    usermod -aG sudo developer && \
    chown ${uid}:${gid} -R /home/developer

WORKDIR /tmp
RUN wget -q 'https://download.jetbrains.com/idea/ideaIU-2018.3.4.tar.gz' && \
    tar xzf ideaIU-2018.3.4.tar.gz && rm ideaIU-2018.3.4.tar.gz && \
    mv idea-* /opt/idea && \
    ln -s /opt/idea/bin/idea.sh /usr/local/bin/idea.sh

WORKDIR /

USER developer
ENV HOME /home/developer
ENV PATH="${PATH}:/home/developer/.local/bin"
CMD mkdir -p /home/developer/.local/bin
# swamp
CMD curl -L "https://github.com/felixb/swamp/releases/download/v0.10.0/swamp_amd64" --create-dirs -o ~/.local/bin/swamp
CMD chmod +x  ~/.local/bin/swamp
CMD PATH=$PATH:~/.local/bin
# run idea
#CMD /usr/local/bin/idea.sh
