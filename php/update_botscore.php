<?php

include_once("dbconnect.php");
$email = $_POST['email'];
$score= $_POST['score'];

$score++;

$sql = "SELECT * FROM tbl_bot WHERE user_email = '$email'";
$result = $conn->query($sql);
    if($result -> num_rows > 0){
        $sqlupdate = "UPDATE tbl_bot SET score=$score WHERE user_email='$email'";
        if($conn-> query($sqlupdate) ===TRUE){
            echo 'success';
        }else{
            echo 'failed';
        }
    }else{
        echo "failed";
    }
?>