<?php


require 'main.php';

print_r(test('EIqrKJ8XV5cPmpM0FowZAjktLlSxQv9u'));
/*
	echo strtotime("2021-02-25 07:14");
	echo "\n";
	echo strtotime(date("Y-m-d", strtotime("2021-02-25 07:14")));

	$permitted_chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
	$api_key = substr(str_shuffle($permitted_chars), 0, 32);
	print("\n\n\n $api_key");

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
  		margin-bottom: 35px;\"><a href=\"https://nomadika.asia/PickApp/verification.php?key=$api_key\"; style=\"text-decoration: none;
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
		font-size: 0.8em;\" href=\"https://nomadika.asia/PickApp/verification.php?key=$api_key\">https://nomadika.asia/PickApp/verification.php?key=$api_key</a>
		</p>
	</div>
</body>
</html>";

$headers  = "Content-type: text/html; charset=windows-1251 \r\n";
$headers .= "From: PickApp <admin@nomadika.asia>\r\n";
$headers .= "Reply-To: PickApp <admin@nomadika.asia>\r\n";

mail('gutaryov@mail.ru', "Welcome to PickApp!", $message, $headers);
echo '<script>window.close()</script>';
/*
$message = '
<!DOCTYPE html>
<html>
    <head>
<meta charset="utf-8" />
        <title>Титул</title>
    </head>
    <body>
        <a href="#" class="btn btn-primary">Click Here</a>
Instead, write it like this:
<table border="0" cellpadding="0" cellspacing="0" class=»btn btn-primary»>
<tr>
<td align="center">
<table border="0" cellpadding="0" cellspacing="0">
<tr>
<td> <a href="" target="_blank">Take action now</a> </td>
</tr>
</table>
</td>
</tr>
</table>
    </body>
</html>';


	$headers = 'From: PickApp <admin@nomadika.asia>' . PHP_EOL .
    	'Reply-To: PickApp <admin@nomadika.asia>' . PHP_EOL .
    	'X-Mailer: PHP/' . phpversion();
//We are glad to welcome you to our system! Authorize your account - https://nomadika.asia/PickApp/verification.php?key=$api_key 
		mail('gutaryov@mail.ru', "Welcome to PickApp!", $message, $headers);








$to  = "Mary &lt;mary@example.com>, " ;
$to .= "Kelly &lt;kelly@example.com>";

$subject = "Birthday Reminders for August";

*/


?>