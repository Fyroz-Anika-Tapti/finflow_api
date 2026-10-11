<?php

include '../connection.php';

$data = json_decode(file_get_contents('php://input'), true);

$res = [];

if (
    isset($data['user_id']) &&
    isset($data['Cost_income_head_id']) &&
    isset($data['transaction_date'])
) {

    $res = $cc->common_insert('transactions', $data);

}

echo json_encode($res);