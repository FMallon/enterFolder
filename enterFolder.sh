#!/bin/bash

enterFolder(){

	result=$(tree -d -L 1 | grep $1 | sed 's/^[^0-9A-Za-z]*//')
  
  #define an array
  declare -a dirList
  #in docs 'enter My' returns MyProjects\nMyPythonScripts\nMyShellScripts
  #can maybe iterate through new line in 'echo "$result"' to allow option for a list in number form or dropdown menu
  #create an array from results of all the options?

  #-debug
  #echo "$result" > debug_file.txt

  while IFS= read -r directory; do
    if [ -n "$directory" ]; then
      dirList+=("$directory")
    fi
  done <<<"$result"    

  #-debug
  #printf '%q\n' "${dirList[0]}" > debug_file.txt
  
  dirListLength=${#dirList[@]}
  #-debug
  #echo "$dirListLength" 


  if [ $dirListLength -gt 1 ]; then
    
    echo -e "\nThere are ${dirListLength} matching directories:\n"
    
    CHOICE="Choose desired directory by number: "
    
    select directory in "${dirList[@]}"; do

      directory_choice="$directory"
      cd "$directory_choice" && break

    done
    echo -e "\n"
  
  elif [ $dirListLength -eq 1 ]; then
    if [ -n "$BASH_VERSION" ]; then
      cd "${dirList[0]}"
    elif [ -n "$ZSH_VERSION" ]; then
      cd "${dirList[1]}"
    fi 

  else
    echo "Cannot find match, please re-try a different pattern!"
  fi
}

enterFolder $1

#Take in result.  Iterate through result, and asign to array based on if there is a next line.
#if array.length() > 1, then do some shit.
#
#This script works, however, it's not as clean as I want it:
# -issues using CHOICE/PS3 input variable.  Can use it in a while loop or if statement.  
