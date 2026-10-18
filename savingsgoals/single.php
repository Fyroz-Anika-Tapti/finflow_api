<?php

include '../connection.php';

$id = $_GET['id'];

$result = $cc->common_select(
    'savings_goals',
    '*',
    ['id' => $id]
);

echo json_encode($result);