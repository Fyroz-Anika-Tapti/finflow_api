<?php

include '../connection.php';

$data = $_POST;

$res = [];

if (
    isset($data['target_amount'])
) {

    $head_data['head_type']=5;
    $head_data['user_id']=1;
    $head_data['head_name']=$data['goal_name'];
    $head_data['status']=1;
    $res = $cc->common_insert('transaction_head', $head_data);
    if($res['status']){
        $data['transaction_head_id']=$res['data'];
        $res1 = $cc->common_insert('savings_goals', $data);
    }

}

echo json_encode($res1);
