#!/bin/bash

readEnvs(){
  echo "Exporting ENV vars:"
  set -a

  lines=`cat .env | sed -E 's/#.*$//' | sed -E 's/[ ]+=[ ]/=/' | sed -E 's/[ ]*$//' | sed -E 's/[ ]*//' | grep -v '^[[:space:]]*$'`;
  while read -r line
  do
      key=`echo $line | sed -E 's/^(.*)=.*$/\1/'`
      value=`echo $line | sed -E 's/^.*=(.*)$/\1/'`
      echo " - $key"
      export "$key=$value"
  done <<< "$lines"

  set +a
}
