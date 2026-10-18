<?php

include '../connection.php';

$data = $_POST;

$res = [];

if (
    isset($data['loan_amount'])
) {

    $res = $cc->common_insert('loans', $data);

}

echo json_encode($res);
