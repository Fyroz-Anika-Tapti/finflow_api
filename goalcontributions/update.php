<?php
include '../connection.php';

$data = json_decode(file_get_contents('php://input'), true);

if (!$data) {
    $data = $_POST;
}

$id = $_GET['id'];

$res = $cc->common_update(
    'goal_contributions',
    $data,
    ['id' => $id]
);

echo json_encode($res);