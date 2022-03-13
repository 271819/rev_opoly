<?php
include_once("dbconnect.php");

$name = $_POST['name'];

$sqldeluser = "DELETE FROM tbl_user WHERE name = '$name'";
if ($conn->query($sqldeluser) === TRUE) {
    echo "success";
} else {
    echo "failed";
}
?>