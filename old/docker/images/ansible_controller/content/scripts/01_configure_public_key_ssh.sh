#!/bin/bash
more "$HOME/.ssh/authorized_keys.ext" >> "$HOME/.ssh/authorized_keys"
chown ansible:ansible "$HOME/.ssh/authorized_keys"
chmod 600 "$HOME/.ssh/authorized_keys"

