#!/bin/sh

CURRENT_DIR=$(pwd)

# Create a gitconfig file in the home dir.
touch ~/.gitconfig
echo "[include]\n    path = $CURRENT_DIR/gitconfig" > ~/.gitconfig
