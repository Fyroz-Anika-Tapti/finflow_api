<?php

include '../connection.php';

$id = $_GET['id'];

$res = $cc->common_delete(
    'transaction_head',
    ['id' => $id]
);

echo json_encode($res);
