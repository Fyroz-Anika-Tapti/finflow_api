<?php

include '../connection.php';

$data = $_POST;

$id = $_GET['id'];

$res = $cc->common_update(
    'savings_goals',
    $data,
    ['id' => $id]
);

echo json_encode($res);