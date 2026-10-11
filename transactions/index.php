<?php

include '../connection.php';

$result = $cc->common_select('transactions');

echo json_encode($result);