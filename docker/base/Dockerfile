FROM ubuntu:latest

ARG USER="ansible"
ARG GROUP="ansible"

ARG HOME=/home/$USER
ARG SSH_CONFIG_DIR=$HOME/.ssh
ENV HOME=$HOME

#Install dependencies
RUN apt-get update && \
    apt-get install -y openssh-server software-properties-common sudo nano && \
    apt-add-repository ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y ansible

#Create user and group ansible in docker container
RUN groupadd $GROUP
RUN useradd -m -d $HOME $USER -g $GROUP --shell /bin/bash

#Allow user to escalate permissions
RUN sed -e '/%sudo/ s/^#*/#/' -i /etc/sudoers
RUN echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

#Prepare structure for passwordless login (01_configure_public_key_ssh.sh will finish configure in runtime)
RUN mkdir -p $SSH_CONFIG_DIR
RUN chown $USER:$GROUP -R $SSH_CONFIG_DIR
RUN touch $SSH_CONFIG_DIR/authorized_keys
RUN chmod 600 $SSH_CONFIG_DIR/authorized_keys


#Generate a new rsa key
RUN ssh-keygen -t rsa -N '' -f "$HOME/.ssh/id_rsa"

#Copy scripts and fix permissions
COPY content $HOME
RUN chown -R $USER:$GROUP $HOME
RUN chmod 700 -R $HOME

EXPOSE 22

WORKDIR $HOME

ENTRYPOINT ["./init.sh"]