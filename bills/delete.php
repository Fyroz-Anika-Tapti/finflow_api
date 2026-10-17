<?php

include '../connection.php';

$id = $_GET['id'];

$res = $cc->common_delete(
    'recurring_expenses',
    ['id' => $id]
);

echo json_encode($res);
