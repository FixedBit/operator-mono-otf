#!/bin/bash

URL=https://fonts.cdnfonts.com/css/operator-mono
DIR=woff

mkdir -p ${DIR}

curl -s ${URL} \
    -H 'Host: fonts.cdnfonts.com' \
    -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:33.0) Gecko/20100101 Firefox/33.0' \
    -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' \
    -H 'Accept-Language: en-US,en;q=0.5' \
    -H 'Referer: https://fonts.cdnfonts.com/css' \
    -H 'Connection: keep-alive' \
    --compressed \
    | grep 'https://' \
    | sed "s|.*url('\(.*\)') format.*|\1|" \
    | while read fontUrl
do
    filename=$(echo ${fontUrl} | sed 's|.*/||')
    echo "Downloading ${fontUrl} to ${DIR}/${filename}"
    wget -q "${fontUrl}" -O "${DIR}/${filename}"
done

echo
echo "Done!"
