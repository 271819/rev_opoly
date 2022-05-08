<?php
$servername = "localhost";
$username = "hubbuddi_revopolyadminn";
$password = "2xmdMYuwMVu9";
$dbname = "hubbuddi_revopolydb";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn ->connect_error){
    die("Connection failed:" . $conn->connect_error);
}
?>