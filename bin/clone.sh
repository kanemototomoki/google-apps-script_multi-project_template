#!/bin/zsh
printf "Input Project Name >> "; read project_name

cd ./src && mkdir ${project_name} && cd ${project_name}
clasp clone
