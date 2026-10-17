<?php

include '../connection.php';

$id = $_GET['id'];

$res = $cc->common_delete(
    'budgets',
    ['id' => $id]
);

echo json_encode($res);
