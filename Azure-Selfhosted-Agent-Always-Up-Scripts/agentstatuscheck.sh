#!/bin/bash
agtsts=$(ps aux|grep -i "Agent.Listener run" | awk '{print $11}' | grep /home/obb-agent/myagent/bin/Agent.Listener| awk 'NR==1{print $1}')
Date=$(date)
if [ $agtsts == "/home/obb-agent/myagent/bin/Agent.Listener" ]; then
  echo $Date"-Agent service is running" >> /home/obb-agent/myagent/agentstatus.txt
else
  echo $Date"-Agent service is not running, Starting service" >> /home/obb-agent/myagent/agentstatus.txt
  /bin/bash /home/obb-agent/myagent/run.sh &
fi
