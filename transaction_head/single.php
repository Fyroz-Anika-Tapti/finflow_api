<?php

include '../connection.php';

$id = $_GET['id'];

$result = $cc->common_select(
    'transaction_head',
    '*',
    ['id' => $id]
);

echo json_encode($result);