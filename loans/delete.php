<?php

include '../connection.php';

$id = $_GET['id'];

$res = $cc->common_delete(
    'loans',
    ['id' => $id]
);

echo json_encode($res);
