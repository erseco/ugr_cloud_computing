#!/bin/bash

DOCKER_SERVER_1=docker1
DOCKER_SERVER_2=docker2

PREVIOUS_SCALE=0

LOGFILE=saed.log

#
# Function to write to LOG_FILE
#
write_log()
{
  if [ ! -e "$LOGFILE" ] ; then
    touch "$LOGFILE"
  fi
  while read text
  do
      local logtime=`date "+%Y-%m-%d %H:%M:%S"`
      echo $logtime": $text" | tee -a $LOGFILE;
  done
}

check_nginx_status()
{

    echo "Checking nginx status..." | write_log

    status=$(curl --silent localhost/nginx_status | grep -ioE " [0-9]+ [0-9]+ [0-9]+")
    arr=($(echo $status | tr " " "\n"))
    handled_connections=${arr[1]}
    handled_requests=${arr[2]}
    requests_per_connection=$(($handled_requests/$handled_connections))

    echo "Request per connection: $requests_per_connection" | write_log

    echo $requests_per_connection

    return $requests_per_connection

}


scale_docker_node()
{
    SERVER=$1
    N_CONTAINERS=($2)

    echo "Scaling ${SERVER} with ${N_CONTAINERS} owncloud containers" | write_log

    ssh ${SERVER} "docker-compose up --scale owncloud=$N_CONTAINERS -d"

}

scale_docker()
{
    N_CONTAINERS= $2

    scale_docker_node $DOCKER_SERVER_1 $N_CONTAINERS
    scale_docker_node $DOCKER_SERVER_2 $N_CONTAINERS

}

get_docker_containers_ports()
{

    SERVER=$1

    string=$(ssh ubuntu@${SERVER} docker ps --format "\{\{.Ports\}\}")
    pattern="^.*:([0-9]+)->.*tcp"
    for word in $string
    do
        [[ $word =~ $pattern ]]
        if [[ ${BASH_REMATCH[0]} ]]
        then
            match="${match:+match }${BASH_REMATCH[0]}"
            PORT=${BASH_REMATCH[1]}

            echo "Adding Linked Contianer $SERVER:$PORT to servers.conf" | write_log
            echo " server $SERVER:$PORT;" >> /home/ubuntu/servers.conf

        fi
    done

}

update_nginx_upstream_server()
{
    echo "Cleaning servers.conf" | write_log
    echo "" > /home/ubuntu/servers.conf

    get_docker_containers_ports $DOCKER_SERVER_1
    get_docker_containers_ports $DOCKER_SERVER_2


    echo "Reloading nginx (gracefully)" | write_log
    sudo service nginx reload

}

saed()
{

    echo "Auto-Scale Service started" | write_log

    # Start the initial owncloud configuration (node1)
    scale_docker_node $DOCKER_SERVER_1 1

    # Start a second owncloud (node2) after a little wait to let finish the 1st
    sleep 5
    scale_docker_node $DOCKER_SERVER_2 1

    echo "Initial nginx configuration" | write_log
    update_nginx_upstream_server

    sleep 5

    while true; do

        requests_per_connection= check_nginx_status

        echo $requests_per_connection

        scale=2

        if [[ $PREVIOUS_SCALE != $scale ]] ; then

            scale_docker $scale

            PREVIOUS_SCALE=$scale

            sleep 2

            update_nginx_upstream_server

            echo "Auto-Scale Service scaled $scale" | write_log

        fi

        sleep 5
    done

}

saed









