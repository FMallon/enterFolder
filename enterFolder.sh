#!/bin/bash

enterFolder(){

	result=$(tree -d -L 1 | grep $1 | sed 's/^[^0-9A-Za-z]*//')

  # define an array
  #declare -a dirList
  dirList=()

  # in docs 'enter My' returns MyProjects\nMyPythonScripts\nMyShellScripts
  # can maybe iterate through new line in 'echo "$result"' to allow option for a list in number form or dropdown menu
  # create an array from results of all the options?

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

  # get rid of the excess from tree that is set to array; last element
  #--Remember, using "unset -v" does not work to get rid of the actual element.  It removes the value, but not the actual element.  Also doesn't work in zShell! Assign temp_array, leave out last element, then make dirList=temp_array;
  
  # declare -a temp_array
  temp_array=()

  if [ -n "$BASH_VERSION" ]; then

    for (( i=0; i<$dirListLength-1; i++ )); do
    
      temp_array[i]=${dirList[i]}

    done
  
  elif [ -n "$ZSH_VERSION" ]; then

    for (( i=1; i<$dirListLength; i++ )); do
      
      temp_array[i]=${dirList[i]}

    done

  fi

  #-debug
  #echo "Temp array is: ${temp_array[@]}"
  
  # make dirList as temp_array to get rid of unnecessary last element
  dirList=("${temp_array[@]}")

  # reset the dirListLength
  dirListLength=${#dirList[@]}

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
