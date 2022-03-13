<?php
$servername = "localhost";
$username = "javathre_revopolyadminn";
$password = "2xmdMYuwMVu9";
$dbname = "javathre_revopolydb";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn ->connect_error){
    die("Connection failed:" . $conn->connect_error);
}
?>