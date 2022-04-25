<?php

include_once("dbconnect.php");
$name = $_POST['name'];
$phone = $_POST['matric'];
$email = $_POST['email'];
$encoded_string = $_POST["encoded_string"];
$imgstatus = "yes";					
$sql = "SELECT * FROM tbl_user WHERE user_email = '$email'";
$result = $conn->query($sql);
    if($result -> num_rows > 0){
        $sqlupdate = "UPDATE tbl_user SET name='$name', matric='$phone' ,imgstatus ='$imgstatus' WHERE user_email='$email'";
        if($conn-> query($sqlupdate) ===TRUE){
            $decoded_string = base64_decode($encoded_string);
        $filename = mysqli_insert_id($conn);
        $path = '../images/profile/'.$email.'.png';
        $is_written = file_put_contents($path, $decoded_string);
            echo 'success';
        }else{
            echo 'failed';
        }
    }else{
        echo "failed";
    }
?>