<?php

include '../connection.php';

$data = $_POST;

$res = [];

if (
    isset($data['frequency'])
) {

    $res = $cc->common_insert('recurring_expenses', $data);

}

echo json_encode($res);
