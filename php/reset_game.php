<?php

include_once("dbconnect.php");

$user_email = $_POST['email'];

$user = "SELECT * FROM tbl_user WHERE user_email = '$user_email'";
    $result = $conn->query($user);
    if ($result->num_rows > 0) {
        $sqlupdate = "UPDATE tbl_user SET score = '0', money = '15000' WHERE user_email = '$user_email'";
        if ($conn->query($sqlupdate) === TRUE){
                echo 'success';
        }else{
                echo 'failed';
        }
    }else{
        echo "failed";
    }

$bot = "SELECT * FROM tbl_bot WHERE user_email = '$user_email'";
    $botresult = $conn->query($bot);
    if ($botresult->num_rows > 0) {
        $sqlbotupdate = "UPDATE tbl_bot SET score = '0', money = '15000' WHERE user_email = '$user_email'";
        if ($conn->query($sqlbotupdate) === TRUE){
                echo 'success';
        }else{
                echo 'failed';
        }
    }else{
        echo "failed";
    }
    
$technology = "DELETE FROM tbl_technology WHERE email = '$user_email'";
    if ($conn->query($technology) === TRUE) {
        echo "success";
    } else {
            echo "failed";
    }
?>