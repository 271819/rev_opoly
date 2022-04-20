<?php
include_once("dbconnect.php");

$email = $_POST['email'];

$loadbotdetails = "SELECT * FROM tbl_technology WHERE email ='$email' AND playertechnology != ''";
$result = $conn-> query($loadbotdetails);


if($result ->num_rows >0){
    $response["playertechnology"]=array();
    while ($row = $result -> fetch_assoc()){
        $list = array();
        $list[playertechnology] = $row['playertechnology'];
        array_push($response["playertechnology"],$list);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>