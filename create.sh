#!/bin/sh
sudo docker run --rm -v /home/misha/code:/home/misha/code -v /home/misha/Downloads:/home/misha/Downloads --name my_codetainer -it codetainer
