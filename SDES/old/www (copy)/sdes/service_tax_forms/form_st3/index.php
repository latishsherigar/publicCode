<?php
// Report simple running errors
error_reporting(E_ERROR | E_WARNING | E_PARSE);

$fin_year='';
$fin_period='';
$fst3_assessee_name='' ;
$fst3_premises_reg_no='' ;
$fst3_lastday_amt_payable='';
$rfsc_desc = array();
$ipsvcs_desc = array();
$rfsc_desc_no = array();
$ipsvcs_desc_no = array();
$rfsc_desc_count=0;
$ipsvcs_desc_count=0;

include("../../common/php/lib.php") ;

$REPORT_SERVER_PATH=$REPORT_SERVER_PATH."rep_src=fst3";

include("functions.php") ;

connect_db();

clean_submit_data();

if($_REQUEST["operation"]=="savedata"){
  if(validate_data()){
    save_data();
  }
}

if($_REQUEST["operation"]=="loaddata"){
  load_data();
}

if($_REQUEST["operation"]=="add_pdsc"){
  add_pdsc_data();
}

if($_REQUEST["operation"]=="del_pdsc"){
  del_pdsc_data();
}


include("form_st3.html") ;

close_db();

?>
