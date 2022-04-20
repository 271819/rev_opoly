<?php
include_once("dbconnect.php");

$technology = $_POST['technology'];

$checkbottechnology = "SELECT * FROM tbl_technology WHERE bottechnology = '$technology' ";
$botresult = $conn-> query($checkbottechnology);

$checkplayertechnology = "SELECT * FROM tbl_technology WHERE playertechnology = '$technology' ";
$playerresult = $conn-> query($checkplayertechnology);

if($botresult ->num_rows >0){
    echo "bot";
}else if($playerresult ->num_rows >0){
    echo "player";
}
else{
    echo "nodata";
}
?>