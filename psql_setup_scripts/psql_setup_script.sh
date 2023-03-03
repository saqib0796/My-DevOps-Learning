#!/bin/bash
        read -p "Enter Resource Group : " rgname
        read -p "Enter DB Username : " username
        read -p "Enter Database server env: " environment
        read -p "Enter Host Endpoint : " endpoint
        read -p "Enter Azure Postgres Database Server Name : " databaseserver
        read -p "Enter Database Name : " database
        read -s -p "Enter password : " password

        if [ $environment == "events" ]; then
                d=`date +%d%m%y%H%M%S`
                ipaddress=$(curl ifconfig.co) 
                echo "Adding My IP "$ipaddress" In Azure PSQL Database Fire Wall" 
                #az sql server list -g rg-obuoc-stage-unistad-we1
                az postgres server firewall-rule create -g $rgname -s $databaseserver -n ClientIPAdress$d --start-ip-address $ipaddress --end-ip-address $ipaddress
                wait
                az postgres server configuration set --name shared_preload_libraries --resource-group $rgname --server $databaseserver --value TIMESCALEDB
                wait
                az postgres server restart -g $rgname -n $databaseserver

                export PGPASSWORD=$password; 
                psql -d postgres -U $username -h $endpoint -p 5432 -f create_db.sql
                echo "%%%%%%%%%%%%%%%%%%%%%%%%%(Database Created)%%%%%%%%%%%%%%%%%%%%%%%%%"
                psql -d $database -U $username -h $endpoint -p 5432 -f create_schema.sql
                echo "%%%%%%%%%%%%%%%%%%%%%%%%%(Database Schema Created)%%%%%%%%%%%%%%%%%%%%%%%%%"
                psql -d $database -U $username -h $endpoint -p 5432 -f create_event_hypertable.sql
                echo "%%%%%%%%%%%%%%%%%%%%%%%%%(Database Event Hyperscal Setting Created)%%%%%%%%%%%%%%%%%%%%%%%%%"
                exit 1
        else
                d=`date +%d%m%y%H%M%S`
                ipaddress=$(curl ifconfig.co) 
                echo "Adding My IP "$ipaddress" In Azure PSQL Database Fire Wall" 
                #az sql server list -g rg-obuoc-stage-unistad-we1
                az postgres server firewall-rule create -g $rgname -s $databaseserver -n ClientIPAdress$d --start-ip-address $ipaddress --end-ip-address $ipaddress
                wait
                export PGPASSWORD=$password;      
                psql -d postgres -U $username -h $endpoint -p 5432 -f create_db.sql
                echo "%%%%%%%%%%%%%%%%%%%%%%%%%(Database Created)%%%%%%%%%%%%%%%%%%%%%%%%%"
                psql -d $database -U $username -h $endpoint -p 5432 -f create_schema.sql
                echo "%%%%%%%%%%%%%%%%%%%%%%%%%(Database Schema Created)%%%%%%%%%%%%%%%%%%%%%%%%%"
                psql -d $database -U $username -h $endpoint -p 5432 -f create_key_constraints.sql
                echo "%%%%%%%%%%%%%%%%%%%%%%%%%(Database Key Constraint Created)%%%%%%%%%%%%%%%%%%%%%%%%%"
                psql -d $database -U $username -h $endpoint -p 5432 -f checkComponentLookup.sql
                exit 1                
                
                echo "UOC database"
                # pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
                # useradd -m -p "$pass" "$username"
                # usermod -u $userid $username
                # groupmod -g $groupid $username
                # [ $? -eq 0 ] && echo "User has been added to system with desired UserID & GroupID!" || echo "Failed to add a user!"
        fi