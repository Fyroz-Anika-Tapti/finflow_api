<?php

include '../connection.php';

$id = $_GET['id'];

$result = $cc->common_query("SELECT transaction_details.* from transaction_details 
join savings_goals on savings_goals.transaction_head_id=transaction_details.transaction_head
where savings_goals.id=$id");

echo json_encode($result);