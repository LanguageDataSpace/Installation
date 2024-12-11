#!/bin/bash

echo "git clone"
git clone https://github.com/LanguageDataSpace/Deployment.git

echo "Get into the directory"
cd Deployment

echo "list branches"
git branch -a

echo "checkout"
git checkout -b 0.8.0 origin/0.8.0

echo "pull"
git pull

echo "cd to docker-compose and create required directrories"
cd docker-compose
bash prepare.sh
