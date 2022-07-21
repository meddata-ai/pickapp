<?php

require 'main.php';
header('Content-Type: application/json');

if($_REQUEST['id'] == 'getDeliver'){
	echo json_encode(getDelivers($_REQUEST['departure'],$_REQUEST['destination'],$_REQUEST['date']));
}

if($_REQUEST['id'] == 'getSender'){
	echo json_encode(getSenders($_REQUEST['departure'],$_REQUEST['destination'],$_REQUEST['date']));
}

if($_REQUEST['id'] == 'getFavorite'){
	echo json_encode(getFavorite($_REQUEST['favorites']));
}

if($_REQUEST['key'] == 'getUserImage'){
	echo json_encode(getUserImage($_REQUEST['apiKey']));
}

?>