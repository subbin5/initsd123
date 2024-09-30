#!/usr/bin/env bash
SDCARD_PATH=/media/user/bootfs
CONFIGTXT=config.txt
CMDLINETXT=cmdline.txt

# SD카드를 인식한다
function detectSD(){
    while true; do
        if [ -d /media/user/bootfs ]; then
            echo "SD 카드가 발견됨."
            return
        fi
        sleep 1
    done
}

echo before detectSD
detectSD
echo after detectSD

# cmdline.txt 파일을 탐지
function detectCMD(){
    sleep 1
    if [ -f "${SDCARD_PATH}/${CMDLINETXT}" ];then
        echo "cmdline.txt 가 발견됨."
        return 0
    else
        return 1
    fi
}

detectCMD
isCMDLINE=$?

# 192.168.111.1을 찾아 수정
IPADDR=111.111.111.111
if [ $isCMDLINE -eq 0 ]; then
    sed -i "s/${IPADDR}/192.168.111.1/" "${SDCARD_PATH}/${CMDLINETXT}"
    if [ $? -eq 0 ]; then
        echo "${CMDLINETXT} 문서가 수정되었습니다."
    else
        echo "${CMDLINETXT} 문서가 수정되지 않았습니다."
    fi
fi

# 파일 수정 후 알림, 수정할 내용이 없습니다.

umount /media/user/bootfs
echo "SD카드 분리"