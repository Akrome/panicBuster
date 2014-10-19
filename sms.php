<?php
 error_reporting(0);
 $request = array_merge($_GET, $_POST);
 // check that request is inbound message
 if(isset($request['msisdn'])){ //sms
  $tmp = explode(':',$request['text']);
  $data = array('id' => $tmp[0],
  		'glat' => $tmp[1],
		'glong' => $tmp[2],
		'hacc' => $tmp[3]);
  $data['type'] = 'sms';
  $data['json'] = "{\"id\":\"{$data['id']}\",\"glat\":{$data['glat']},\"glong\":{$data['glong']},\"hacc\":{$data['hacc']}}";
 }
 elseif(isset($request['id'])){ //web
  $data = $request;
  $data['type'] = 'web';
  $data['json'] = "{\"id\":\"{$data['id']}\",\"glat\":{$data['glat']},\"glong\":{$data['glong']},\"hacc\":{$data['hacc']}}";
 }
$log = "####################\n" . date('D, d M Y H:i:s') . "\n" . print_r($data,true) . "\n";
 file_put_contents('sms.log', $log, FILE_APPEND);
 if(isset($request['delete']))
  @unlink('alert.log');
 elseif($data['json'])
  file_put_contents('alert.log', $data['json']);
 
 echo 'END';

/* function file_put_contents($name, $data, $opt){
  $h = fopen($name, $opt);
  if(!$h)
   return false;
  fwrite($h,$data);
  fclose($h);
  return true;
}*/


