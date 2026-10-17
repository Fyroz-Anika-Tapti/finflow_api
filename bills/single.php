<?php

include '../connection.php';

$id = $_GET['id'];

$result = $cc->common_select(
    'recurring_expenses',
    '*',
    ['id' => $id]
);

echo json_encode($result);