<?php

include '../connection.php';

$data = $_POST;

$res = [];

if (
    isset($data['amount'])
) {

    $res = $cc->common_insert('goal_contributions', $data);

}

echo json_encode($res);
