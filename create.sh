#!/bin/sh
sudo docker run -d --restart=always --security-opt seccomp:unconfined -v /home/misha/code:/home/misha/code -v /home/misha/Downloads:/home/misha/Downloads --name my_codetainer codetainer
