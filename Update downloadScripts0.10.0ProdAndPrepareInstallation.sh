#!/bin/bash

echo "git clone"
git clone https://github.com/LanguageDataSpace/Deployment.git

echo "Get into the directory"
cd Deployment

echo "list branches"
git branch -a

echo "checkout"
git checkout -b 0.10.0prod origin/0.10.0prod

echo "pull"
git pull

echo "cd to docker-compose and create required directrories"
cd docker-compose
bash prepare.sh
