#!/bin/bash
cd /opt/cam/
./save_maindoor_stream.sh &
./save_mainentrance_stream.sh &
./save_northveranda_stream.sh &
./save_hall_stream.sh &
./save_parking_stream.sh &
./save_backside_stream.sh &
./save_compound_stream.sh &
./monitor_cam_stream_process.sh /media/HD/cctv/main_door > /media/HD/cctv/main_door/monitor.log 2>&1&
./monitor_cam_stream_process.sh /media/HD/cctv/entrance_cam1 > /media/HD/cctv/entrance_cam1/monitor.log 2>&1&
./monitor_cam_stream_process.sh /media/HD/cctv/hall > /media/HD/cctv/hall/monitor.log 2>&1&
./monitor_cam_stream_process.sh /media/HD/cctv/north_veranada > /media/HD/cctv/north_veranada/monitor.log 2>&1&
./monitor_cam_stream_process.sh /media/HD/cctv/parking > /media/HD/cctv/parking/monitor.log 2>&1&
./monitor_cam_stream_process.sh /media/HD/cctv/backside > /media/HD/cctv/backside/monitor.log 2>&1&
./monitor_cam_stream_process.sh /media/HD/cctv/compound > /media/HD/cctv/compound/monitor.log 2>&1&
./organise.sh /media/HD/cctv/main_door > /media/HD/cctv/main_door/organise.log 2>&1&
./organise.sh /media/HD/cctv/entrance_cam1 > /media/HD/cctv/entrance_cam1/organise.log 2>&1&
./organise.sh /media/HD/cctv/hall > /media/HD/cctv/hall/organise.log 2>&1&
./organise.sh /media/HD/cctv/north_veranada > /media/HD/cctv/north_veranada/organise.log 2>&1&
./organise.sh /media/HD/cctv/parking > /media/HD/cctv/parking/organise.log 2>&1&
./organise.sh /media/HD/cctv/backside > /media/HD/cctv/backside/organise.log 2>&1&
./organise.sh /media/HD/cctv/compound > /media/HD/cctv/compound/organise.log 2>&1&
./rebootonfailure.sh &

node /home/admin/cam/nodejs_file_service/server.js >/media/HD/cctv/main_door/viewer.log 

