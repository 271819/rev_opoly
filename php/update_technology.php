<?php

include_once("dbconnect.php");
$email = $_POST['email'];
$technology = $_POST['technology'];
$status = $_POST['status'];



if($status=="player"){
    $technology = "INSERT INTO tbl_technology(playertechnology,email) VALUES('$technology','$email')";
        if ($conn->query($technology) === TRUE){
            echo "success";
        }else{
            echo "failed";
        }
}else{
     $technology = "INSERT INTO tbl_technology(bottechnology,email) VALUES('$technology','$email')";
        if ($conn->query($technology) === TRUE){
            echo "success";
        }else{
            echo "failed";
        }
}

?>