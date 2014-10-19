<?php
 error_reporting(0);
 $request = array_merge($_GET, $_POST);
 // check that request is inbound message
 //$log = "####################\n" . date('D, d M Y H:i:s') . "\n" . print_r($request,true) . "\n";
 //file_put_contents('ajax.log', $log, FILE_APPEND);
 $data = @file_get_contents('alert.log');
 echo $data;
 //@unlink('alert.log');
 //echo '{"id": "TechCrunch","glat": 51.5094237669427,"glong": -0.0848180949428173,"hacc": 65.0}';

/* function file_put_contents($name, $data, $opt){
  $h = fopen($name,'a');
  if(!$h)
   return false;
  fwrite($h,$data);
  fclose($h);
  return true;
 }*/
 

