docker build -t opaldev .
IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
xhost + $IP
docker run --name opal_intellij -ti --rm \
       -e DISPLAY=$IP:0 \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       opaldev# run idea
docker exec -u developer -d opal_intellij /usr/local/bin/idea.sh
