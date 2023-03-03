#/bin/bash!

mkdir azagent;
cd azagent;
curl -fkSL -o vstsagent.tar.gz https://vstsagentpackage.azureedge.net/agent/2.196.2/vsts-agent-linux-x64-2.196.2.tar.gz;
tar -zxvf vstsagent.tar.gz; 
if [ -x "$(command -v systemctl)" ]; 
then ./config.sh --deploymentgroup --deploymentgroupname "OBBDeployment" --acceptteeeula --agent $HOSTNAME --url https://dev.azure.com/hostcountry/ --work _work --projectname 'UNISTAD' --runasservice; sudo ./svc.sh install; sudo ./svc.sh start;
else ./config.sh --deploymentgroup --deploymentgroupname "OBBDeployment" --acceptteeeula --agent $HOSTNAME --url https://dev.azure.com/hostcountry/ --work _work --projectname 'UNISTAD';
./run.sh; fi


