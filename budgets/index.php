
<?php
include '../connection.php';
include '../auth_check.php';
$result=$cc->common_query("SELECT budgets.*, (select sum(transaction_details.dr) from transaction_details where transaction_details.transaction_head=budgets.transaction_head_id) as dr, (select sum(transaction_details.cr) from transaction_details where transaction_details.transaction_head=budgets.transaction_head_id) as cr FROM `budgets`");
echo json_encode($result);