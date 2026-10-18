<?php

include '../connection.php';

$id = $_GET['id'];

$res = $cc->common_delete(
    'savings_goals',
    ['id' => $id]
);

echo json_encode($res);
