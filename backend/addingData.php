<?php

require 'main.php';
header('Content-Type: application/json');

if($_REQUEST['id'] == 'addDeliver'){
	echo json_encode(addDeliver($_REQUEST['apiKey'], $_REQUEST['departure'], $_REQUEST['destination'], $_REQUEST['date'], $_REQUEST['fee'], $_REQUEST['comment'], $_REQUEST['phone'], $_REQUEST['email'], $_REQUEST['viewEmail'], $_REQUEST['viewPhone']));
}

if($_REQUEST['id'] == 'addSender'){
	echo json_encode(addSender($_REQUEST['apiKey'], $_REQUEST['departure'], $_REQUEST['destination'], $_REQUEST['date'], $_REQUEST['fee'], $_REQUEST['comment'], $_REQUEST['phone'], $_REQUEST['email'], $_REQUEST['viewEmail'], $_REQUEST['viewPhone']));
}

?>