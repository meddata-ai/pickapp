<?php
require 'main.php';
header('Content-Type: application/json');
define('UPLOAD_ERR_OK', 0);
$message = ''; 
$fileName1 = '';



if (isset($_FILES['uploadedFile1']) && $_FILES['uploadedFile1']['error'] === UPLOAD_ERR_OK)
{
	// get details of the uploaded file
	$fileTmpPath = $_FILES['uploadedFile1']['tmp_name'];
	$fileName = $_FILES['uploadedFile1']['name'];
	$fileSize = $_FILES['uploadedFile1']['size'];
	$fileType = $_FILES['uploadedFile1']['type'];
	$fileNameCmps = explode(".", $fileName);
	$fileExtension = strtolower(end($fileNameCmps));

	// sanitize file-name
	$newFileName1 = md5(time() . $fileName) . '.' . $fileExtension;
	// check if file has one of the following extensions
	$allowedfileExtensions = array('jpg', 'jpeg', 'png');

	if (in_array($fileExtension, $allowedfileExtensions))
	{
		// directory in which the uploaded file will be moved
		$uploadFileDir = './uploaded_files/';
		$dest_path = $uploadFileDir . $newFileName1;

		if(move_uploaded_file($fileTmpPath, $dest_path)) 
		{
			$message ='File is successfully uploaded.';
			$fileName1 = $newFileName1;
		}
		else 
		{
			$message = 'There was some error moving the file to upload directory. Please make sure the upload directory is writable by web server.';
		}
	}
	else
	{
		$message = 'Upload failed. Allowed file types: ' . implode(',', $allowedfileExtensions);
	}
}
else
{
	$message = 'There is some error in the file upload. Please check the following error.<br>';
	$message .= 'Error:' . $_FILES['uploadedFile1']['error'];
}

$fileName2 = '';
if (isset($_FILES['uploadedFile2']) && $_FILES['uploadedFile2']['error'] === UPLOAD_ERR_OK)
{
	// get details of the uploaded file
	$fileTmpPath = $_FILES['uploadedFile2']['tmp_name'];
	$fileName = $_FILES['uploadedFile2']['name'];
	$fileSize = $_FILES['uploadedFile2']['size'];
	$fileType = $_FILES['uploadedFile2']['type'];
	$fileNameCmps = explode(".", $fileName);
	$fileExtension = strtolower(end($fileNameCmps));

	// sanitize file-name
	$newFileName2 = md5(time() . $fileName) . '.' . $fileExtension;

	// check if file has one of the following extensions
	$allowedfileExtensions = array('jpg', 'jpeg', 'png');

	if (in_array($fileExtension, $allowedfileExtensions))
	{
		// directory in which the uploaded file will be moved
		$uploadFileDir = './uploaded_files/';
		$dest_path = $uploadFileDir . $newFileName2;

		if(move_uploaded_file($fileTmpPath, $dest_path)) 
		{
			$message ='File is successfully uploaded.';
			$fileName2 = $newFileName2;
		}
		else 
		{
			$message = 'There was some error moving the file to upload directory. Please make sure the upload directory is writable by web server.';
		}
	}
	else
	{
		$message = 'Upload failed. Allowed file types: ' . implode(',', $allowedfileExtensions);
	}
}
else
{
	$message = 'There is some error in the file upload. Please check the following error.<br>';
	$message .= 'Error:' . $_FILES['uploadedFile2']['error'];
}

$fileName3 = '';
if (isset($_FILES['uploadedFile3']) && $_FILES['uploadedFile3']['error'] === UPLOAD_ERR_OK)
{
	// get details of the uploaded file
	$fileTmpPath = $_FILES['uploadedFile3']['tmp_name'];
	$fileName = $_FILES['uploadedFile3']['name'];
	$fileSize = $_FILES['uploadedFile3']['size'];
	$fileType = $_FILES['uploadedFile3']['type'];
	$fileNameCmps = explode(".", $fileName);
	$fileExtension = strtolower(end($fileNameCmps));

	// sanitize file-name
	$newFileName3 = md5(time() . $fileName) . '.' . $fileExtension;

	// check if file has one of the following extensions
	$allowedfileExtensions = array('jpg', 'jpeg', 'png');

	if (in_array($fileExtension, $allowedfileExtensions))
	{
		// directory in which the uploaded file will be moved
		$uploadFileDir = './uploaded_files/';
		$dest_path = $uploadFileDir . $newFileName3;

		if(move_uploaded_file($fileTmpPath, $dest_path)) 
		{
			$message ='File is successfully uploaded.';
			$fileName3 = $newFileName3;
		}
		else 
		{
			$message = 'There was some error moving the file to upload directory. Please make sure the upload directory is writable by web server.';
		}
	}
	else
	{
		$message = 'Upload failed. Allowed file types: ' . implode(',', $allowedfileExtensions);
	}
}
else
{
	$message = 'There is some error in the file upload. Please check the following error.<br>';
	$message .= 'Error:' . $_FILES['uploadedFile3']['error'];
}

if($_REQUEST['id'] == 'addPost'){
	echo json_encode(addPosts($_REQUEST['comment'], $_REQUEST['phone'], $_REQUEST['email'], "{'image1': '$fileName1', 'image2': '$fileName2', 'image3': '$fileName3'}"));
}

//$_SESSION['message'] = $message;
//header("Location: index.php");

?>