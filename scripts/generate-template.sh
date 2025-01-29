#!/bin/sh

# filename
filename=$1
# file extension
extension="${filename##*.}"

if [ "$extension" == "cpp" ]; then
   cp -n ~/.config/nvim/templates/skeleton.cpp ./$filename;
# elif [ "$extension" == "tex" ]; then
#    cp -n ~/.config/nvim/templates/latex_template.tex ./$filename;
else
  echo "Template not found"
  exit
fi

nvim $filename
