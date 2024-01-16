#!/bin/bash

# deprecated 
ssh-keygen -t rsa -b 4096 -f aliyun -N ''
echo "pubkey = $(cat aliyun.pub)" > ../pubkey.tfvars