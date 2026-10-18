<?php

include '../connection.php';

header('Access-Control-Allow-Origin: http://localhost:5173');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Authorization, Content-Type, Accept');

$id = $_GET['id'];

$res = $cc->common_delete(
    'goal_contributions',
    ['id' => $id]
);

echo json_encode($res);
