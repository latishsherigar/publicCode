
#!/bin/bash

year=$(cut -c 1-2 <<< '$(date)')

if [ $year -le 20 ]; then
  echo "sleeping for 2 mins to get correct time"
  sleep 120           
fi

#echo "sleeping for 2 mins to get correct time"
#sleep 120
echo "starting work"
inputdir=$1
#inputdir=/tmp
cameraurl=$2

while true
do
	workingdir=$inputdir
	mkdir -p $workingdir	
        cd  $workingdir
        #ffmpeg -i $cameraurl -rtsp_transport tcp -c:a aac -c:v copy -map 0 -f segment -strftime 1 -segment_time 300 -segment_format mp4 -reset_timestamps 1 "$workingdir/$foldername/%Y%m%d_%H%M%S.mp4" < /dev/null
	ffmpeg -nostdin -hide_banner -y  -rtsp_transport tcp -use_wallclock_as_timestamps 1 -i $cameraurl  -vcodec copy -acodec copy -f segment -reset_timestamps 1 -segment_time 300 -segment_format mkv -segment_atclocktime 1 -strftime 1 $workingdir/%Y%m%dT%H%M%S.mkv
	sleep 1
	echo "Current working dir is " $workingdir
done
