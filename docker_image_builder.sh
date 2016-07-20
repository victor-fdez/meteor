#!/bin/bash

versions=(
  #1.3.5.1
  #1.3.5
  #1.3.4.4
  #1.3.4.3
  #1.3.4.2
  #1.3.4.1
  #1.3.4
  #1.3.3.1
  #1.3.3.1
  #1.3.3
  1.3.2.4
  1.3.2.3
  1.3.2.2
  1.3.2.1
  1.3.2
  1.3.1
  1.3
  1.2.1
  1.2
)

for ver in ${versions[@]}; do
  tmp_file=$( tempfile )
  #Build an images for every version in the array
  docker build --build-arg BUILD_METEOR_VERSION=$ver ./ | tee $tmp_file
  if [ $? -eq  0 ]; then
    #If build was successful then push the image to docher hub
    digest=$(tail -1 $tmp_file | sed -n -e 's/Successfully built \([0-9a-f]*\)/\1/pg')
    tag="victor755555/meteor:$ver"
    docker tag $digest $tag 
    docker push $tag
  else
    break
  fi
done
