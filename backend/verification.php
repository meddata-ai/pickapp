<?php

require 'main.php';
//header('Content-Type: application/json');
	

if($_GET['key'] != null){

	
	echo json_encode(verificationF($_GET['key']));

	
}

//echo '<script>window.close()</script>';

?>