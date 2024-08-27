#!/bin/sh

input=$1

# Finds the result from tree based on 
result=$(tree -d -L 1 | grep $input | grep -v -- 'directories$' | sed 's/^[^0-9A-Za-z]*//' | sed 's/ ->.*//')

#-debug
#echo $result

# initialize the array for directories.
dirList=()
#declare -a dirList

getDirectories(){

  # read in results into array dirList
  while IFS= read -r directory; do 
    
    if [ -n "$directory" ]; then
      dirList+=("$directory")
    fi
  
  done <<<"$result"

  dirListLength="${#dirList[@]}"

}


# this is unnecessary now, but keep for future use! 
#filterDirectories(){

  # store into a temp array, then transfer elements back into dirList to get rid of the final element from "tree" that is unnecessary
  #--cannot use "unset -v" as it doesn't actually remove the last element, just its value
  
#  local temp_array=()
    

    # zShell's array index begins at 1, not 0; so accounting for this here! 
#    if [ -n "$BASH_VERSION" ]; then

#      for (( i=0; i<$dirListLength; i++)); do

#        temp_array[i]=${dirList[i]}

#      done

#    elif [ -n "$ZSH_VERSION" ]; then

#      for (( i=1; i<$dirListLength; i++)); do
    
#        temp_array[i]=${dirList[i]}

#     done

#    fi

#    #-debug
#    #echo "Temp array is: ${temp_array[@]}"
#    dirList=("${temp_array[@]}")

#    # reset the dirListLength
#    dirListLength=${#dirList[@]}

#}


enterFolder(){

  getDirectories

  #-debug
  #echo -e "Directory size is: $dirListLength\n${dirList[@]}"

  # should allow for smooth use with 'enter .' to display all available directories 
  if [[ $dirListLength -gt 1 || "$input" == "." ]]; then

    echo -e "\nThere are $dirListLength matching directories:\n"

    CHOICE="Choose desired directory by number: "

    select directory in "${dirList[@]}"; do

      directory_choice="$directory"

      cd "$directory_choice" && 
      break

    done

    echo -e "\n"

  # if only one possible option, then proceed; of course, Bash and zShell arrays start with [0] & [1] respectively
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

main(){

enterFolder

}

main $1
