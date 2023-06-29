#!/bin/bash
# This script is meant to install configurations relevant for Linux tools running under WSL

echo "Installing Bash Profile..."
ln -sf $(realpath "Bash/.bashrc") ~/.bashrc
ln -sf $(realpath "Bash/.profile") ~/.profile 

echo "Done."