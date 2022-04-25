<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require '/home8/javathre/public_html/s271819/revopoly/php/PHPMailer/Exception.php';
require '/home8/javathre/public_html/s271819/revopoly/php/PHPMailer/PHPMailer.php';
require '/home8/javathre/public_html/s271819/revopoly/php/PHPMailer/SMTP.php';

include_once("dbconnect.php");

$name = $_POST['name'];
$user_email = $_POST['email'];
$password = $_POST['password'];
$passha1 = sha1($password);
$otp = rand(1000,9999);
$money ="15000";
$status = "active";
$imgstatus = "no";

$sqlbotregister = "INSERT INTO tbl_bot(user_email,money) VALUES('$user_email','$money')";
if ($conn->query($sqlbotregister) === TRUE){
}

$sqlregister = "INSERT INTO tbl_user(name,user_email,password,otp,money,imgstatus) VALUES('$name','$user_email','$passha1','$otp','$money','$imgstatus')";
if ($conn->query($sqlregister) === TRUE){

        
    echo "success";
    // sendEmail($otp,$user_email);
}else{
    echo "failed";
}


// function sendEmail($otp,$user_email){
//     $mail = new PHPMailer(true);
//     $mail->SMTPDebug = 0;                                   //Disable verbose debug output
//     $mail->isSMTP();                                        //Send using SMTP
//     $mail->Host       = 'mail.javathree99.com';             //Set the SMTP server to send through
//     $mail->SMTPAuth   = true;                               //Enable SMTP authentication
//     $mail->Username   = 'revopoly@javathree99.com';         //SMTP username
//     $mail->Password   = 'rkBuOnm+.{(b';                     //SMTP password
//     $mail->SMTPSecure = 'tls';         
//     $mail->Port       = 587;
    
//     $from = "revopoly@javathree99.com";
//     $to = $user_email;
//     $subject = "From REV-OPOLY ON THE GO. Please Verify your account";
//     $message = 
       
//         "<h1>&emsp;&ensp;Email Confirmation </h1>
//         <hr>
//         <h3>
//         <p>
//         Hey, You are almost ready to start enjoying REV-OPOLY ON THE GO. 
//         <p>
//         Simply click the link below to verify your email. <p>
//         </h3>
//         <p><br>
//         &emsp;&emsp;&emsp;
//         <a href='https://javathree99.com/s271819/revopoly/php/verify_account.php?email=".$user_email."&key=".$otp."'>
//         Verify Email Address.
//         </a>";

//     $mail->setFrom($from,"REV-OPOLY ON THE GO");
//     $mail->addAddress($to);                                             //Add a recipient
    
//     //Content
//     $mail->isHTML(true);                                                //Set email format to HTML
//     $mail->Subject = $subject;
//     $mail->Body    = $message;
//     $mail->send();
// }
?>