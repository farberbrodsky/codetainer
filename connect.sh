#!/bin/bash
ssh -q -o "StrictHostKeyChecking=no" $(cat /var/run/codetainer-ip)
