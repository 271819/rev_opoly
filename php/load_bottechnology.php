<?php
include_once("dbconnect.php");

$email = $_POST['email'];

$loadbotdetails = "SELECT * FROM tbl_technology WHERE email ='$email' AND bottechnology != '' ";
$result = $conn-> query($loadbotdetails);


if($result ->num_rows >0 ){
    $response["bottechnology"]=array();
    while ($row = $result -> fetch_assoc()){
        $list = array();
        $list[bottechnology] = $row['bottechnology'];
        array_push($response["bottechnology"],$list);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>