
#!/bin/bash

function kill_ffmpeg () { 
	
        pid=$(ps -ef|grep ffmpeg|grep "$working_dir"| awk '{print $2}')
	echo "pid is "$pid
	if [ $pid -ge 0 ]; then
            kill -9 $pid
   	    echo "kill ffmpeg - pid - "$pid
	    echo "sleeping for 60 seconds"
   	    sleep 60
        fi
}

working_dir=$1
echo "sleeping for 180 seconds"
sleep 180
echo "starting"

while true
do

#for dir in $working_dir/*; do 
		echo "dir - "$working_dir

		last_mod_file=$(ls -Art "$working_dir"/*.mkv|tail -1)
		
		if [ -z "$last_mod_file" ]; then
		  echo "No files found. Killing ffmpeg."
		  kill_ffmpeg
		  continue;
		fi
		
		echo "$last_mod_file"
		file_last_mod_date=$(date -r $last_mod_file)
		cur_date=$(date)
		echo $file_last_mod_date
		echo $cur_date
		file_last_mod_date_sec=$(date -d "$file_last_mod_date" +"%s")
		cur_date_sec=$(date -d "$cur_date" +"%s")
		file_last_mod_diff_sec=$(($cur_date_sec - $file_last_mod_date_sec))

		echo $file_last_mod_diff_sec
		
		if [ $file_last_mod_diff_sec -ge 60 ]; then
			kill_ffmpeg
		fi
#	done
echo "sleeping for 30 seconds"
sleep 30
echo "done"

done


