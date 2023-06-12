#Deriving the latest base image
FROM ubuntu:latest

#Labels as key value pair
LABEL Maintainer="siddhant"

#Install dependencies
RUN apt-get update -y && \
    apt-get install -y vim git python3 python3-pip && \
    pip install wheel Flask firebase-admin

#Add files
ADD devpara-fbServiceAccountKey.json /home/devpara/scripts/devpara-fbServiceAccountKey.json
ADD fs_api.py /home/devpara/scripts/fs_api.py
ADD main-v2.py /home/devpara/scripts/main-v2.py

#Run files
RUN python3 /home/devpara/scripts/fs_api.py
RUN python3 /home/devpara/scripts/main-v2.py