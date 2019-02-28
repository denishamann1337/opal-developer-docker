docker build -t opaldev .
docker run --name opal_intellij -ti --rm \
              opaldev# run idea
#docker exec -u developer -d opal_intellij /usr/local/bin/idea.sh
