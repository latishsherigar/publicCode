 #!/bin/bash

working_dir=$1
cd $working_dir
echo "Working dir - "$working_dir;

function isFileEligibleTobeArchived (){
		#$FILE=$1
		#echo "FILE - " $FILE
		curr_year=$(date +%Y)
		curr_month=$(date +%m)

		#echo "cur year month is "$curr_year$curr_month

                if [[ "$FILE" == *"$curr_year$curr_month"* ]]; then
		    #echo "current month file"	
		     return 0;	
		fi;

		#if [ "$curr_month" = "01" ]; then
                #   prev_month=12
                #   prev_year=$(($curr_year - 1))      
                #else
		#   prev_month=$(($curr_month - 1)) 
                #   prev_year=$curr_year    	  
                #fi;
		nowmonth=$(date +%Y-%m)
		prev_year_month=$(date -d "$nowmonth-15 last month" '+%Y%m')
		#echo "prev year month is " $prev_year_month
		
		 if [[ $FILE == $prev_year_month* ]]; then
                     
                	#echo " prev months file. check mod date if its older than month"

			#last_mod_file=$(ls -Art "$working_dir"/*.mkv|tail -1)
			file_last_mod_date=$(date -r $FILE)
			#echo "file last mod date - " $file_last_mod_date
			file_last_mod_date_sec=$(date -d "$file_last_mod_date" +%s)
			#echo "last mod in sec - "$file_last_mod_date_sec
	                curr_date_sec=$(date -d "$(date)" +%s)
			#echo "curr date in sec - " $curr_date_sec
			day_diff_sec=$(($curr_date_sec - $file_last_mod_date_sec))
	                #echo "day diff sec - " $day_diff_sec


			
			if [ $day_diff_sec -ge 2764800 ]; then 
			  #echo $FILE "-" $day_diff_sec
			  return 1;
			else
			  return 0;	
			fi
		else
			#echo "old file. Delete without checking mod date"
			return 1;
		fi

		#return 0;
}


while true
do


for year_dir in */ ; do
	
	  curr_month=$(date +%m) 
	  curr_year=$(date +%Y) 
          nowmonth=$(date +%Y-%m)
          prev_month=$(date -d "$nowmonth-15 last month" '+%m')

          echo "curr_month - "$curr_month       
	  echo "curr_year - "$curr_year
	  echo "Dir - "$year_dir

	if [[ $year_dir != $curr_year"/" ]] && [[ $curr_month != "01" ]]; then
	  echo "removing year directory - "$working_dir$year_dir
	  rm -fr $working_dir$year_dir
	  continue
	fi
	 
	cd $working_dir/$year_dir

	for month_dir in * ; do
	  echo $month_dir
	  	

	  if [[ $curr_month == $month_dir ]] || [[ $month_dir == $prev_month ]]; then
		echo "skipping dir -"$month_dir
	  else
		echo "clearning dir -"$month_dir
		rm -fr $month_dir
          fi 		

	  if [[ $month_dir == $prev_month ]]; then
		  cd $month_dir
		  curr_day=$(date +%d) 	
		  for day_dir in * ; do
          		 echo  $day_dir
			if [[ $day_dir -le $curr_day ]] ; then
				echo "clearning day dir -"$day_dir
			fi
			 
	   	  done
	  fi 	

	done


	 #curr_year=$(date +%Y)
 	 #nowmonth=$(date +%Y-%m)
	 #prev_year=$(date -d "$nowmonth-15 last month" '+%Y')
	 #curr_month=$(date +%m)	

	
done

cd $working_dir


 	 for FILE in $(find . |grep mkv); 
 		do 
    			echo "START - "$FILE;
    
			 #skip when no files are available
   			 if [[ ! -e $FILE ]];  then  
				 echo "No files to process.";
				 continue;
			 fi;
    
			 #echo "call  archive eligible  " 
    			isFileEligibleTobeArchived ;
    
			 archive_eligible=$?;
    			#echo "archive eligible - " $archive_eligible

    			#skip if this is not eligible to be archived
    			if [ $archive_eligible -ne 1 ];then 
      				#echo "skipping " $FILE;
      				continue;
    			fi
    
			  echo "Processing " $FILE;
			  rm -fr $FILE;	
 

 
	 done
 #done


 echo "sleeping for an hour"
 sleep 3600
 echo "done"
done
