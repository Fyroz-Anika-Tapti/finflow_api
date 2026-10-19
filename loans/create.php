<?php

include '../connection.php';

$data = $_POST;

$res = [];

if (
    isset($data['loan_amount'])
) {
    $head_data['head_type']=6;
    $head_data['user_id']=1;
    $head_data['head_name']=$data['loan title'];
    $head_data['status']=1;
    $res = $cc->common_insert('transaction_head', $head_data);
    if($res['status']){
    $res = $cc->common_insert('loans', $data);

}
}

echo json_encode($res1);

