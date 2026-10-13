<?php

include '../connection.php';
include '../auth_check.php';

$result = $cc->common_query('SELECT th.*,transaction_head.`head_name` as parent_head FROM `transaction_head` as th left JOIN transaction_head on th.parent_id=transaction_head.id');

echo json_encode($result);
