
<?php
include '../connection.php';
include '../auth_check.php';
$result=$cc->common_select('recurring_expenses');
echo json_encode($result);