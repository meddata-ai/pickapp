<?php
require 'main.php';
define('UPLOAD_ERR_OK', 0);

header('Content-Type: application/json');

if($_REQUEST['key'] == 'editName')
	echo json_encode(editUserName($_REQUEST['apiKey'], $_REQUEST['name']));

if($_REQUEST['key'] == 'getUserImageUrl')
	echo json_encode(getUserImageUrl($_REQUEST['apiKey']));




if($_REQUEST['key'] == 'editPhone')
	echo json_encode(editPhoneName($_REQUEST['apiKey'], $_REQUEST['phone'], $_REQUEST['countryCode'], $_REQUEST['country']));

if($_REQUEST['key'] == 'image'){


	
	try{
		$fileName1 = '';
		if (isset($_FILES['userImage']) && $_FILES['userImage']['error'] === UPLOAD_ERR_OK)
		{
			// get details of the uploaded file
			$fileTmpPath = $_FILES['userImage']['tmp_name'];
			$fileName = $_FILES['userImage']['name'];
			$fileSize = $_FILES['userImage']['size'];
			$fileType = $_FILES['userImage']['type'];
			$fileNameCmps = explode(".", $fileName);
			$fileExtension = strtolower(end($fileNameCmps));
			$fileExtension='jpg';

			// sanitize file-name
			$newFileName1 = md5(time() . $fileName) . '.' . $fileExtension;
			// check if file has one of the following extensions
			$allowedfileExtensions = array('jpg', 'jpeg', 'png');

			if (in_array($fileExtension, $allowedfileExtensions))
			{
				// directory in which the uploaded file will be moved
				$uploadFileDir = './user_image/';
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
			$message .= 'Error:' . $_FILES['userImage']['error'];
		}
		echo json_encode(editUserImage($_REQUEST['apiKey'], $fileName1));
	}
	catch(Exception $e){
		echo false;	
	}
}

?>