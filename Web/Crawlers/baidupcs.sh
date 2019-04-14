#!/bin/zsh

FILE_LIST=( '01.zip' \
            '02.zip' \
            '03.zip' \
            '04.zip'
          );

curlToAria2()
{
  PARAMS=""
  BASE_URL="https://pcs.baidu.com/rest/2.0/pcs/file?method=download&app_id=265486&path=/apps/bypy/火影/"

  for PARAM in "${@:2}"
  do
    PARAMS="${PARAMS} '${PARAM}'"
  done

  PARAMS=$( echo $PARAMS | sed s/"Range: bytes.\+\-"/A:b/g | sed "s/'-H'/--header/g" | sed "s/ '--compressed'//g" )

  for f in "${FILE_LIST[@]}" ; do

    local DOWNLOADER_ARGUMENTS='-c -s16 -k1M -x16 -j16 -t3 --connect-timeout=3 --file-allocation=none' # 3s timeout for faster retrying
    $(exit 1)
    while [ $? -ne 0 ]; do
      echo "Retrying curlToAria2 ..."
      local cmd="aria2c ${DOWNLOADER_ARGUMENTS} '${BASE_URL}${f}' ${PARAMS} -o '$f'"
      echo "$cmd"
      eval "$cmd"
    done;

  done
}


curlToAria2 'https://pcs.baidu.com/rest/2.0/pcs/file?method=download&app_id=265486&F06-11.zip' \
-H 'Connection: keep-alive' \
-H 'Upgrade-Insecure-Requests: 1' \
-H 'DNT: 1' \
-H 'User-Agent: Mozilla/5.0' \
-H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' \
-H 'Referer: https://pan.baidu.com/disk/home?' \
-H 'Accept-Encoding: gzip, deflate, br' \
-H 'Accept-Language: en-US,en;q=0.9' \
-H 'Cookie: BAIDUID=xxx' \
--compressed
