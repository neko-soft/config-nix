#!/usr/bin/env bash

pkill -f -9 cmatrix
pkill -f -9 asciiquarium 
pkill -f -9 cbonsai 
pkill -f -9 pipes.sh 
pkill -f -9 glava  


kitty -e cmatrix & sleep 0.05
kitty -e asciiquarium & sleep 0.05
kitty -e cbonsai -li & sleep 0.05
kitty -e pipes.sh & sleep 0.05
kitty -e nohup glava
