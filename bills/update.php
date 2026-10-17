<?php

include '../connection.php';

$data = $_POST;

$id = $_GET['id'];

$res = $cc->common_update(
    'recurring_expenses',
    $data,
    ['id' => $id]
);

echo json_encode($res);