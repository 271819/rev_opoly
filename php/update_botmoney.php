<?php

include_once("dbconnect.php");
$email = $_POST['email'];
$money =$_POST['money'];
$updatemoney= $_POST['updatemoney'];


    $money = $money + $updatemoney;

$sql = "SELECT * FROM tbl_bot WHERE user_email = '$email'";
$result = $conn->query($sql);
    if($result -> num_rows > 0){
        $sqlupdate = "UPDATE tbl_bot SET money=$money WHERE user_email='$email'";
        if($conn-> query($sqlupdate) ===TRUE){
            echo 'success';
        }else{
            echo 'failed';
        }
    }else{
        echo "failed";
    }
?>