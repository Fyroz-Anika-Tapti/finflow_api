<?php
include '../connection.php';

$id=$_GET['id'];

$res=[];
if($_POST['user_id']){
    $res=$cc->common_update('transactions', $_POST, ['id'=>$id]);
}
echo json_encode($res);

