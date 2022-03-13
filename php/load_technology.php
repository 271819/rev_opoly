<?php
include_once("dbconnect.php");

$email = $_POST['email'];

$loadtechnology = "SELECT * FROM tbl_technology WHERE email =$email";

$result = $conn-> query($loadtechnology);
if($result ->num_rows >0){
    echo "success";
}else{
    echo "failed";
}
?>