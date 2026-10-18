
<?php
include '../connection.php';
include '../auth_check.php';
$result=$cc->common_query('SELECT savings_goals.*, (select sum(transaction_details.dr - transaction_details.cr) from transaction_details where transaction_details.transaction_head=savings_goals.transaction_head_id) as achieved FROM `savings_goals`');
echo json_encode($result);