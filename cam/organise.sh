 #!/bin/bash

working_dir=$1
cd $working_dir


function isFileActiveRecording (){
		#$FILE=$1
		echo "FILE - " $FILE
		#last_mod_file=$(ls -Art "$working_dir"/*.mkv|tail -1)
		file_last_mod_date=$(date -r $FILE)
		cur_date=$(date)
		echo $file_last_mod_date
		echo $cur_date
		file_last_mod_date_sec=$(date -d "$file_last_mod_date" +"%s")
		cur_date_sec=$(date -d "$cur_date" +"%s")
		file_last_mod_diff_sec=$(($cur_date_sec - $file_last_mod_date_sec))

		echo $file_last_mod_diff_sec
		
		if [ $file_last_mod_diff_sec -le 30 ]; then 
		  echo "file_last_mod_diff_sec" $file_last_mod_diff_sec
		  return 1;
		fi
		
		#return 0;
}


while true
do
 
 for FILE in *.mkv; 
 do 
    echo "START"
    
    #skip when no files are available
    if [[ ! -e $FILE ]];  then  
      echo "No files to process.";
      continue;
    fi;
    
    echo "is file active recording - " 
    isFileActiveRecording ;
    
    active_recording=$?;
    echo "active_recording " $active_recording

    #skip if this is the active recording file
    if [ $active_recording -eq 1 ];then 
      echo "skipping " $FILE;
      continue;
    fi
    
  echo "Processing " $FILE;
  file_year=$(echo $FILE | cut -c  1-4);
  file_month=$(echo $FILE | cut -c  5-6);
  file_day=$(echo $FILE | cut -c  7-8);
  
  echo $file_year/$file_month/$file_day;

  mkdir -p $file_year/$file_month/$file_day;
  mv $FILE $file_year/$file_month/$file_day/$FILE;

 done

 echo "sleeping for 60 seconds"
 sleep 60
 echo "done"
done
