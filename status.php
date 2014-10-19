<?php
 error_reporting(0);
 $request = array_merge($_GET, $_POST);
 // check that request is inbound message
 $log = "####################\n" . date('D, d M Y H:i:s') . "\n" . print_r($request,true) . "\n";
 file_put_contents('status.log', $log, FILE_APPEND);
 echo 'OK';

/* function file_put_contents($name, $data, $opt){
  $h = fopen($name,'a');
  if(!$h)
   return false;
  fwrite($h,$data);
  fclose($h);
  return true;
}*/
 

