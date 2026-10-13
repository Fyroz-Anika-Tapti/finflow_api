<?php

include '../connection.php';
include '../auth_check.php';
if(isset($_GET['head_type']) && !empty($_GET['head_type'])
){
    $head_type = $_GET['head_type'];
    $result = $cc->common_query('select * from transaction_head where head_type in ('.$head_type.')');
} else {
    $result = $cc->common_select('transaction_head', '*');
}
echo json_encode($result);
