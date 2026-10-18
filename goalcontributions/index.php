<?php
include '../connection.php';
include '../auth_check.php';

$result = $cc->common_select('goal_contributions');

echo json_encode($result);