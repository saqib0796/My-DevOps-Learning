#!/bin/bash

file="/home/obb-agent/myagent/agentstatus.txt"
maxsize=100    # 100 kilobytes
actualsize=$(du -k "$file" | cut -f1)
    if [ $actualsize -ge $maxsize ]; then
        echo size is over $maxsize kilobytes
        > /home/obb-agent/myagent/agentstatus.txt
    else
        echo size is under $maxsize kilobytes
    fi
