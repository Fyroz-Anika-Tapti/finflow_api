
<?php

include '../connection.php';

$data = $_POST;

$res = [];

if (
    isset($data['head_name'])
) {

    $res = $cc->common_insert('transaction_head', $data);

}

echo json_encode($res);
