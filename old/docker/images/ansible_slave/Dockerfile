FROM charlotron/ansible-controller

ARG USER="ansible"
ARG GROUP="ansible"

ARG HOME=/home/$USER

#Convert public key in authorized_keys and remove private key as long as this is not the client
RUN mv "$HOME/.ssh/id_rsa.pub" "$HOME/.ssh/authorized_keys"
RUN rm "$HOME/.ssh/id_rsa"

ENTRYPOINT ["./init.sh"]