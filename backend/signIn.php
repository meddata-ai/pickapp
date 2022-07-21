<?php

require 'main.php';
header('Content-Type: application/json; charset=utf-8');

if($_REQUEST['key'] == 'signIn')
{
	echo json_encode(signIn($_REQUEST['email'], $_REQUEST['password']));
}

if($_REQUEST['key'] == 'forgotPassword')
{
	echo json_encode(forgotPassword($_REQUEST['email']));
}


if($_REQUEST['key'] == 'registration')
{
	echo json_encode(registration($_REQUEST['email'], $_REQUEST['password'], $_REQUEST['phone'], $_REQUEST['countryCode'], $_REQUEST['country'],$_REQUEST['name']));
}


if($_REQUEST['key'] == 'loginSocial')
{
	echo json_encode(loginSocial($_REQUEST['name'], $_REQUEST['email']));
}

?>