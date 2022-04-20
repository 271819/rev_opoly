<?php
include_once("dbconnect.php");

$email = $_POST['email'];

$loadbotdetails = "SELECT * FROM tbl_bot WHERE user_email ='$email'";
$result = $conn-> query($loadbotdetails);


if($result ->num_rows >0){
    $response["botdetails"]=array();
    while ($row = $result -> fetch_assoc()){
        $list = array();
        $list[money] = $row['money'];
        $list[score] = $row['score'];
        array_push($response["botdetails"],$list);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>