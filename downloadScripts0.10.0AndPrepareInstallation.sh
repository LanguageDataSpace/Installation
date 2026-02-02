#!/bin/bash

VERS=0.10.0 

echo "git clone"
git clone https://github.com/LanguageDataSpace/Deployment.git Deployment$VERS

echo "Get into the directory"
cd Deployment$VERS

echo "list branches"
git branch -a

echo "checkout"
git checkout -b $VERS origin/$VERS

echo "pull"
git pull

echo "cd to docker-compose and create required directrories"
cd docker-compose
bash prepare.sh
