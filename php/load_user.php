<?php
include_once("dbconnect.php");

$srcname = $_POST['name'];

if ($srcname == "") {
    $sqlloaduser = "SELECT * FROM tbl_user WHERE NOT name ='admin' ORDER BY name";
} 
else{
    $sqlloaduser = "SELECT * FROM tbl_user WHERE name LIKE '%$srcname%'";
}

$result = $conn-> query($sqlloaduser);

if($result ->num_rows >0){
    $response["user"]=array();
    while ($row = $result -> fetch_assoc()){
        $list = array();
        $list[user_email] = $row['user_email'];
        $list[name] = $row['name'];
        $list[phone] = $row['phone'];
        $list[score] = $row['score'];
        $list[money]=$row['money'];
        // $list[ingredient]=$row['Ingredient'];
        // $list[date]=$row['datareg'];
        array_push($response["user"],$list);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>