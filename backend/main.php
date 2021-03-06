<?php
define('SITE_URL','https://deckwebtech.com/pickapp_demo/');
//defile('SITE_URL','https://pickapp.com.kz/');
require dirname ( __FILE__ )  . "/libs/rb-mysql.php";

R::setup('mysql:host=localhost;dbname=nexa_pickapp', 'nexa_pickapp', '],}sqADCjvZ8');

if(!R::testConnection()){
	echo 'Не удалось подключиться к базе данных';
	exit;
}

function signIn($email, $password){
	$response=array();
	$mass = R::getAll("SELECT * FROM `users` WHERE `email` = ?", [$email]);
    $response['status'] = false;
	$response['data']=null;
	$response['message'] = "Sorry, Invalid credentials!";

	foreach ($mass as $key=> $mas)
	{
	
          if($mas['password'] != md5(md5($password)))
			{
				$response['status'] = false;
				$response['data'] = 'Invalid password';
				
				return $response;
			}

        if($mas['verified'] != 1)
			{
				$response['status'] = false;
				$response['data'] = 'Sorry,Please check your mail to verify!';
				
				return $response;
			}


			if($mas['status'] == 0)
			{
				$response['status'] = true;
				$response['data'] = 'banned';
				
				return $response;
			}
			
			unset($mas['password']);
			
			$response['status'] = true;
			$response['data'] = $mas;
			$response['message'] = "Success!";

			if(isset($mas['image']) && $mas['image']!='')
			{
			$response['data']['image']=SITE_URL.'user_image/'.$mas['image'];
	
			}
			else
			{
			$response['data']['image']='';	
			}
			
			
			return $response;
		
	}

	return $response;

}



function loginSocial($name, $email)
{

    $response=array();
    $response['status'] = false;
	$response['data']=null;
	$response['message'] = "Sorry, Invalid credentials!";


        if($name=='')
			{
			$response['message'] = 'Please provide name';
            return $response;
			}
			if($email=='')
			{
			$response['message'] = 'Please provide email';
            return $response;
			}

$mass = R::getAll("SELECT * FROM `users` WHERE `email` = ?", [$email]);
	if(count($mass) > 0)
	{
			foreach ($mass as $mas)
			{

			$response['status'] = true;
			$response['data'] = $mas;
			$response['message'] = "Success!";

			if(isset($mas['image']) && $mas['image']!='')
			{
			$response['data']['image']=SITE_URL.'user_image/'.$mas['image'];
	
			}
 
			}
			$response['message'] = "User Exists";
			return $response;
            
	}

	else
	{

		$userId = R::getAll("SELECT `id` FROM `users` ORDER BY `id` DESC");	
		$num = $userId[0]['id'] + 1;
        $newPassword = md5(rand(999,22));
        $permitted_chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
		$api_key = substr(str_shuffle($permitted_chars), 0, 32);
        $user = R::dispense('users');
		$user->email = $email;
		$user->password = $newPassword;
		$user->countrycode = '';
		$user->phone = '';
		$user->country = '';
		$user->date = date("d.m.y H:i");
		$user->apikey = $api_key;
		$user->name = $name;
		$user->status = 1;
		$user->verified = 1;
		R::store($user);

		$mass = R::getAll("SELECT * FROM `users` WHERE `email` = ?", [$email]);
	
			foreach ($mass as $mas)
			{

			$response['status'] = true;
			$response['data'] = $mas;
			$response['message'] = "Success!";

			if(isset($mas['image']) && $mas['image']!='')
			{
			$response['data']['image']=SITE_URL.'user_image/'.$mas['image'];
	
			}
			

			}
			$response['message'] = "User created";

			return $response;
        

	}

return $response;
	

}









function registration($email, $password, $phone, $countryCode, $country,$name){
	$response=array();
	$response['status'] = false;
	$response['data']=null;
	$response['message'] = '';

if(!isset($name) || $name=='')
            {
            $response['message'] = "Sorry, Please provide your name.";
            return $response;
            exit;
            }

	 elseif(!isset($email) || $email=='')
            {
            $response['message'] = "Sorry, Please provide email address.";
            return $response;
            exit;
            }

            elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) 
            {

            $response['message'] = "Sorry, Please provide valid email address.";
            return $response;
            exit;            
            }
 
            elseif(!isset($password) || $password=='')
            {
            $response['message'] = "Sorry, Please provide Password.";
            return $response;
            exit;
            }
            
           

	//correction where login=>email
	$mass = R::getAll("SELECT * FROM `users` WHERE `email` = ?", [$email]);
	if(count($mass) > 0)
	{
		$response['message'] = "Sorry, Email Id already exists.";
            return $response;
            exit;
            
	}
	
	$userId = R::getAll("SELECT `id` FROM `users` ORDER BY `id` DESC");	
	$num = $userId[0]['id'] + 1;
	
	$newPassword = md5(md5(trim($password)));
	
	$permitted_chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
	$api_key = substr(str_shuffle($permitted_chars), 0, 32);
	
	$user = R::dispense('users');
	$user->email = $email;
	$user->password = $newPassword;
	//$user->name = "User{$num}";
	$user->countrycode = $countryCode;
	$user->phone = $phone;
	$user->country = $country;
	$user->date = date("d.m.y H:i");
	$user->apikey = $api_key;
	$user->name = $name;
	$user->status = 1;
	$user->verified = 1;
	R::store($user);
	
	$message = "
	<!DOCTYPE html>
	<html lang=\"en\">
	<head>
		<meta charset=\"UTF-8\">
		<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
		<title>Massage</title>
		<link rel=\"preconnect\" href=\"https://fonts.gstatic.com\">
		<link href=\"https://fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap\" rel=\"stylesheet\">
	</head>
	<body style=\"margin: 0;
			padding: 0;
			color: #fff;
			box-sizing: border-box;
			font-family: 'Roboto', sans-serif;\">
		<div style=\"width: auto;
			background: #414141;
			color: #fff;
			padding: 40px 0;\">
			<h1 style=\"text-align: center;
			padding: 0 30px;color: #fff;\">PickApp</h1>
			<h2 style=\"margin-top: 25px;
			font-size: 1.2em;
			padding: 15px 30px;
			background: #12b3c5;
			text-align: center;color: #fff;\">Fast Delivery</h2>
			<p style=\"padding: 0 15px;
			margin-top: 30px;
			font-size: 0.9em;
			line-height: 23px;color: #fff;\">Welcome to PickApp!</p>
			<p style=\"padding: 0 15px;
			margin-top: 30px;
			font-size: 0.9em;
			line-height: 23px;color: #fff;\">We are glad to welcome you to our system! Authorize your account by clicking on the button</p>
			<div style=\"text-align: center;
			margin-top: 35px;
			margin-bottom: 35px;\"><a href=\"https://deckwebtech.com/pickapp_demo/verification.php?key=$api_key\"; style=\"text-decoration: none;
			color: #fff;background: #e66f0a;
			padding: 10px 24px;
			font-weight: 600;
			font-size: 0.9em;
			border-radius: 3px;\" href=\"#\">ACTIVATE</a></div>
			<p  style=\"padding: 0 15px;
			margin-top: 30px;
			font-size: 0.9em;
			line-height: 23px;\"><b style=\"font-size: 0.9em;
		line-height: 23px;color: #fff;\">Click or Copy the Activation Link</b></p>
			<p style=\"margin-top: 10px; padding: 0 15px;\">
				<a style=\"color: #af703a;
			font-weight: 600;
			font-size: 0.8em;\" href=\"https://deckwebtech.com/pickapp_demo/verification.php?key=$api_key\">https://deckwebtech.com/pickapp_demo/verification.php?key=$api_key</a>
			</p>
		</div>
	</body>
	</html>";

	//$liveurl=https://pickapp.com.kz

	/*$headers  = "Content-type: text/html; charset=windows-1251 \r\n";
	$headers .= "From: PickApp <admin@pickapp.com.kz>\r\n";
	$headers .= "Reply-To: PickApp <admin@pickapp.com.kz>\r\n";

    $mailsend=mail($email, "Welcome to PickApp!", $message, $headers);
	
	if($mailsend)
	{

	    $newuser = R::getAll("SELECT `id` FROM `users` WHERE `email` = ?", [$email]);
		$response['status'] =true;
		$response['message']= 'Thanks, Please check your mail to verify!';
				
		$response['data'] = array('name'=>$name,"email"=>$email,"id"=>$newuser[0]['id']);
	}*/


        $mass = R::getAll("SELECT * FROM `users` WHERE `email` = ?", [$email]);
		$response['status'] =true;
		$response['message']= 'Thanks,Your account has been created successfully!';
				
		

foreach ($mass as $key=> $mas)
	{
	     	
			$response['data'] = $mas;

			if(isset($mas['image']) && $mas['image']!='')
			{
			$response['data']['image']=SITE_URL.'user_image/'.$mas['image'];
	
			}
			else
			{
			$response['data']['image']='';	
			}
		
	}


	return $response;

}





function checkUser($phone, $email){
	$users = R::getAll("SELECT `phone`, `email` FROM `users` WHERE `phone` = '$phone' OR `email` = '$email'");
	
	$userId = R::getAll("SELECT `id` FROM `users` ORDER BY `id` DESC");	
	$num = $userId[0]['id'] + 1;
	
	if($users == null){
		
		$permitted_chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
		$api_key = substr(str_shuffle($permitted_chars), 0, 32);
		
		$message = "
<!DOCTYPE html>
<html lang=\"en\">
<head>
	<meta charset=\"UTF-8\">
	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
	<title>Massage</title>
	<link rel=\"preconnect\" href=\"https://fonts.gstatic.com\">
	<link href=\"https://fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap\" rel=\"stylesheet\">
</head>
<body style=\"margin: 0;
		padding: 0;
		color: #fff;
		box-sizing: border-box;
		font-family: 'Roboto', sans-serif;\">
	<div style=\"width: auto;
		background: #414141;
		color: #fff;
		padding: 40px 0;\">
		<h1 style=\"text-align: center;
		padding: 0 30px;color: #fff;\">PickApp</h1>
		<h2 style=\"margin-top: 25px;
    	font-size: 1.2em;
    	padding: 15px 30px;
    	background: #12b3c5;
    	text-align: center;color: #fff;\">Fast Delivery</h2>
		<p style=\"padding: 0 15px;
		margin-top: 30px;
		font-size: 0.9em;
		line-height: 23px;color: #fff;\">Welcome to PickApp!</p>
		<p style=\"padding: 0 15px;
		margin-top: 30px;
		font-size: 0.9em;
		line-height: 23px;color: #fff;\">We are glad to welcome you to our system! Authorize your account by clicking on the button</p>
		<div style=\"text-align: center;
  		margin-top: 35px;
  		margin-bottom: 35px;\"><a href=\"https://pickapp.com.kz/verification.php?key=$api_key\"; style=\"text-decoration: none;
		color: #fff;background: #e66f0a;
    	padding: 10px 24px;
    	font-weight: 600;
    	font-size: 0.9em;
    	border-radius: 3px;\" href=\"#\">ACTIVATE</a></div>
		<p  style=\"padding: 0 15px;
		margin-top: 30px;
		font-size: 0.9em;
		line-height: 23px;\"><b style=\"font-size: 0.9em;
    line-height: 23px;color: #fff;\">Click or Copy the Activation Link</b></p>
		<p style=\"margin-top: 10px; padding: 0 15px;\">
			<a style=\"color: #af703a;
    	font-weight: 600;
		font-size: 0.8em;\" href=\"https://pickapp.com.kz/verification.php?key=$api_key\">https://pickapp.com.kz/verification.php?key=$api_key</a>
		</p>
	</div>
</body>
</html>";

$headers  = "Content-type: text/html; charset=windows-1251 \r\n";
$headers .= "From: PickApp <admin@pickapp.com.kz>\r\n";
$headers .= "Reply-To: PickApp <admin@pickapp.com.kz>\r\n";

mail($email, "Welcome to PickApp!", $message, $headers);
		
		$user = R::dispense('users');
		$user->apikey = $api_key;
		$user->name = "User{$num}";
		$user->phone = $phone;
		$user->email = $email;
		$user->date = date("d.m.y H:i");
		R::store($user);
	}
}

function test($key){
	$mass = R::getAll("SELECT `image` FROM `users` WHERE `apiKey` = ?", [$key]);
	
	if(count($mass[0]['image']) > 0 && $mass[0]['image'] != '' && $mass[0]['image'] != null){
		return 'true';
	}
	else{
		return 'false';
	}
}

function addDeliver($key, $departure, $destination, $date, $fee, $comment, $phone, $email, $viewEmail, $viewPhone){


    $response=array();
    $response['status'] = false;
	$response['data']=null;
	$response['message'] = "Sorry! apiKey already exists";
    $mass = R::getAll("SELECT `apikey`, `image` FROM `users` WHERE `apiKey` = ?", [$key]);

	$userImage = null;
	if(count($mass)<=0)
	{
		 $userImage = $mass[0]['image'];
		//return $response;
		
	}
	
	$permitted_chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
	$api_key = substr(str_shuffle($permitted_chars), 0, 32);
	$data = R::dispense('delivers');
	$data->apikey = $api_key;
	$data->departure = $departure;
	$data->destination = $destination;
	$data->date = $date;
	$data->fee = $fee;
	$data->comment = $comment;
	$data->phone = ($viewPhone == 'true') ? $phone : '-';
	$data->email = ($viewEmail == 'true') ? $email : '-';
	$data->image = $userImage;
	R::store($data);
	
	//checkUser($phone, $email);
	$response['status'] = true;
	$response['data'] = $data;
	$response['message'] = "Thanks, Data added successfully.";
	return $response;

}

function addSender($key, $departure, $destination, $date, $fee, $comment, $phone, $email, $viewEmail, $viewPhone){



	$response=array();
    $response['status'] = false;
	$response['data']=null;
	$response['message'] = "Sorry! apiKey already exists";

	
	$mass = R::getAll("SELECT `apikey`, `image` FROM `users` WHERE `apiKey` = ?", [$key]);
	$userImage = null;
	if(count($mass)<=0)
	{
		//return $response;
		$userImage = $mass[0]['image'];
		
	}
	
	
	$permitted_chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
	$api_key = substr(str_shuffle($permitted_chars), 0, 32);
	
	$data = R::dispense('senders');
	$data->apikey = $api_key;
	$data->departure = $departure;
	$data->destination = $destination;
	$data->date = $date;
	$data->fee = $fee;
	$data->comment = $comment;
	$data->phone = ($viewPhone =='true') ? $phone : '-';
	$data->email = ($viewEmail == 'true') ? $email : '-';
	$data->image = $userImage;
	R::store($data);
	
	//checkUser($phone, $email);
	
	$response['status'] = true;
	$response['data'] = $data;
	$response['message'] = "Thanks, Data addedd successfully.";
return $response;
}

function getDelivers($departure,$destination,$date){
	

    $response=array();
	$response['status'] = false;
	$response['data'] = array();
	$response['message'] = 'Sorry, data not found!';
		if(!isset($departure) || $departure=='')
		{
		$response['message'] = "Sorry, Please provide departure name.";
		return $response;
		exit;
		}

if(!isset($destination) || $destination=='')
		{
		$response['message'] = "Sorry, Please provide destination name.";
		return $response;
		exit;
		}

if(!isset($date) || $date=='')
		{
		$response['message'] = "Sorry, Please provide date(Y-m-d).";
		return $response;
		exit;
		}

	$users = R::getAll("SELECT * FROM `delivers` WHERE `departure` LIKE '".$departure."' AND `destination` LIKE '".$destination."' AND DATE_FORMAT(`date`,'%Y-%m-%d') like '".$date."' ");
	
	
	
	
	/*foreach($arr as $name => $j){
			if(strtotime(date("Y-m-d", strtotime($i['date']))) == strtotime($name)){
				continue();
			}
			
		}*/
	/*foreach($users as $i)
	{
		
		$dt = date("Y-m-d", strtotime($i['date']));
		
		if($arr["$dt"] != null){
			array_push($arr["$dt"], [$i['departure'], $i['destination'], $i['date'], $i['fee'], $i['comment'], $i['phone'], $i['email'], $i['apikey'], $i['image'] != '' ? $i['image'] : null]);
		}
		else{
			$arr["$dt"] = [[$i['departure'], $i['destination'], $i['date'], $i['fee'], $i['comment'], $i['phone'], $i['email'], $i['apikey'], $i['image'] != '' ? $i['image'] : null]];
		}
	}*/
	

     if(count($users)>0):
     	$response['status'] = true;
     	$response['message']='Success'; 
	foreach($users as $i)
	{
		
		 $img=$i['image'] != '' ? $i['image'] : null;

			$response['data'][] = array('id'=>$i['id'],'departure'=>$i['departure'],'destination'=> $i['destination'],'date'=> $i['date'],'fee'=> $i['fee'], 'comment'=>$i['comment'], 'phone'=>$i['phone'],'email'=> $i['email'],'apikey'=> $i['apikey'],'image'=>$img );
		
	}
    endif;

	return $response;
}	

function getSenders($departure,$destination,$date){
	
	$response=array();
	$response['status'] = false;
	$response['data'] = array();
	$response['message'] = 'Sorry, data not found!';
		if(!isset($departure) || $departure=='')
		{
		$response['message'] = "Sorry, Please provide departure name.";
		return $response;
		exit;
		}

if(!isset($destination) || $destination=='')
		{
		$response['message'] = "Sorry, Please provide destination name.";
		return $response;
		exit;
		}

if(!isset($date) || $date=='')
		{
		$response['message'] = "Sorry, Please provide date(Y-m-d).";
		return $response;
		exit;
		}

	$users = R::getAll("SELECT * FROM `senders` WHERE `departure` LIKE '".$departure."' AND `destination` LIKE '".$destination."' AND DATE_FORMAT(`date`,'%Y-%m-%d') like '".$date."' ");
	
	

     if(count($users)>0):
     	$response['status'] = true;
     	$response['message']='Success'; 
	foreach($users as $i)
	{
		
		 $img=$i['image'] != '' ? $i['image'] : null;

			$response['data'][] = array('id'=>$i['id'],'departure'=>$i['departure'],'destination'=> $i['destination'],'date'=> $i['date'],'fee'=> $i['fee'], 'comment'=>$i['comment'], 'phone'=>$i['phone'],'email'=> $i['email'],'apikey'=> $i['apikey'],'image'=>$img );
		
	}
    endif;

	return $response;
}




function getFavorite($favorites){
	$senders = R::getAll("SELECT * FROM `senders`");
	$delivers = R::getAll("SELECT * FROM `delivers`");
	
	$allList = array_merge($senders, $delivers);
	
	$arr = [];
	
	foreach($allList as $i){
		foreach(json_decode($favorites) as $j){	
			if($i['apikey'] == $j){
				array_push($arr, [$i['departure'], $i['destination'], $i['date'], $i['fee'], $i['comment'], $i['phone'], $i['email'], $i['apikey'], $i['image'] != '' ? $i['image'] : null]);
			}
		}
	}
	
	return $arr;
}

function addPosts($comment, $phone, $email, $image){
	
	$dateTime = date("Y-m-d H:i:s");
	
	$data = R::dispense('posts');
	$data->date = $dateTime;
	$data->message = $comment;
	$data->phone = $phone;
	$data->email = $email;
	$data->image = $image;
	R::store($data);
	
	$response=array();
	

	$response['status'] = true;
	$response['data']=null;
	$response['message'] = "saved";
	return $response;
}

function verificationF($key)
{
   $user = R::getAll("UPDATE `users` SET `verified` = '1' WHERE `apikey` = '$key'");
   $response=array();
	

	$response['status'] = true;
	$response['data'] = $key;
	$response['message'] = "verified";
	return $response;

}

function editUserName($key, $name){

	$response['status'] = false;
	$response['data']=null;
	$response['message'] = "";
	
	try{
		R::getAll("UPDATE `users` SET `name` = '$name' WHERE `apikey` = '$key'");
		$response['status'] = true;
		return $response;

	}
	catch(Exception $e){
		return $response;
	}
}

function editPhoneName($key, $phone, $countryCode='', $country=''){

	$response['status'] = false;
	$response['data']=null;
	$response['message'] = "Sorry!";
	

        if($key=='')
			{
				$response['status'] = false;
				$response['message'] = 'Sorry,Please provide apiKey !';
				
				return $response;
			}

			if($phone=='')
			{
				$response['status'] = false;
				$response['message'] = 'Sorry,Please provide phone !';
				
				return $response;
			}

$mass = R::getAll("SELECT `phone` FROM `users` WHERE `apikey` = ?", [$key]);
	if(count($mass) <=0)
	{
		$response['message'] = "Sorry, Apikey does not exist.";
            return $response;
            exit;
            
	}

	try{
		R::getAll("UPDATE `users` SET `phone` = '$phone', `countrycode` = '$countryCode', `country` = '$country' WHERE `apikey` = '$key'");
		$response['status'] = true;

		$response['message'] = 'Success !';
		return $response;

	}
	catch(Exception $e){

		return $response;
	}
}

function editUserImage($key, $image){
	$response['status'] = false;
	$response['data']=null;
	$response['message'] = "";


$mass = R::getAll("SELECT * FROM `users` WHERE `apikey` = ?", [$key]);
	if(count($mass) <=0)
	{
		$response['message'] = "Sorry, Apikey does not exist.";
            return $response;
            exit;
            
	}
	else
	{
		if($image!='')
		{
		R::getAll("UPDATE `users` SET `image` = '$image' WHERE `apikey` = '$key'");
		}
   $mass = R::getAll("SELECT * FROM `users` WHERE `apikey` = ?", [$key]);

		$response['status'] = true;

			foreach ($mass as $mas)
			{


			//exit;
			$response['data']=$mas;

			$uploadFileDir = './user_image/';
			$dest_path = $uploadFileDir . $mas['image'];

			if(isset($mas['image']) && $mas['image']!='' && file_exists($dest_path)) 
			{
			$response['data']['image']=SITE_URL.'user_image/'.$mas['image'];

			}
			$response['data']['url']=SITE_URL;



			}

			
	}

	return $response;
	
	/*try{

		R::getAll("UPDATE `users` SET `image` = '$image' WHERE `apikey` = '$key'");
		$response['status'] = true;

		return $response;
	}
	catch(Exception $e){
		return $response;
	}*/


}

function getUserImage($key){
	
	$image = R::getAll("SELECT `image` FROM `users` WHERE `apikey` = '$key'");
	
	if($image != null && $image != '' && $image[0]['image'] != null && $image[0]['image'] != ''){
		return $image;	
	}
	else{
		return false;
	}
}


function getUserImageUrl($key){
	
    $response['status'] = false;
	$response['data']=null;
	$response['message'] = "Sorry!";
	$image='';

	$image1 = R::getAll("SELECT `image` FROM `users` WHERE `apikey` = '$key'");
	if(!empty($image1)){$image=$image1[0]['image'];}


                $uploadFileDir = './user_image/';
				$dest_path = $uploadFileDir . $image;

				if(isset($image) && $image!='' && file_exists($dest_path)) 
				{
	$response['status'] = true;

    $response['data']['image']=SITE_URL.'user_image/'.$image;
	$response['message'] = "success!";

	
				}


    
	return $response;
            exit;


}




function forgotPassword($email){
	$response=array();
	$response['status'] = false;
	$response['data']=null;
	$response['message'] = '';

           if(!isset($email) || $email=='')
            {
            $response['message'] = "Sorry, Please provide email address.";
            return $response;
            exit;
            }

            elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) 
            {

            $response['message'] = "Sorry, Please provide valid email address.";
            return $response;
            exit;            
            }
 
            
	$userId = R::getAll("SELECT * FROM `users` WHERE `email` = ?", [$email]);
	if(count($userId) <= 0)
	{
		    $response['message'] = "Sorry, Email Id do not exist.";
            return $response;
            exit;
            
	}
	
	$userPass=rand(1111,99999);
	$newPassword = md5(md5($userPass));
	$updat=R::getAll("UPDATE `users` SET `password` = '$newPassword' WHERE `email` = '$email'");
	
	$message = "
	<!DOCTYPE html>
	<html lang=\"en\">
	<head>
		<meta charset=\"UTF-8\">
		<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
		<title>Forgot Password</title>
		<link rel=\"preconnect\" href=\"https://fonts.gstatic.com\">
		<link href=\"https://fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap\" rel=\"stylesheet\">
	</head>
	<body style=\"margin: 0;
			padding: 0;
			color: #fff;
			box-sizing: border-box;
			font-family: 'Roboto', sans-serif;\">
		<div style=\"width: auto;
			background: #414141;
			color: #fff;
			padding: 40px 0;\">
			<h1 style=\"text-align: center;
			padding: 0 30px;color: #fff;\">PickApp</h1>
			<h2 style=\"margin-top: 25px;
			font-size: 1.2em;
			padding: 15px 30px;
			background: #12b3c5;
			text-align: center;color: #fff;\">Forgot Password</h2>
			
			<p style=\"padding: 0 15px;
			margin-top: 30px;
			font-size: 0.9em;
			line-height: 23px;color: #fff;\">Your new password has been given bleow.<br>Password: $userPass</p>
			<p style=\"padding: 0 15px;
			margin-top: 30px;
			font-size: 0.9em;
			line-height: 23px;color: #fff;\"></p>

			<p style=\"padding: 0 15px;
			margin-top: 30px;
			font-size: 0.9em;
			line-height: 23px;color: #fff;\">Thanks & regards<br>Team</p>
			
	</body>
	</html>";


	$headers  = "Content-type: text/html; charset=windows-1251 \r\n";
	$headers .= "From: PickApp <admin@pickapp.com.kz>\r\n";
	$headers .= "Reply-To: PickApp <admin@pickapp.com.kz>\r\n";
     
	$mailsend=mail($email, "PickApp: Forgot Password", $message, $headers);
	
	if($mailsend)
	{

		$response['status'] =true;
		$response['message']= 'Thanks, A new password has been sent to your email address!';
				
		$response['data'] = array('name'=>$userId[0]['name'],"email"=>$email,"id"=>$userId[0]['id']);
	}

	return $response;
}




?>