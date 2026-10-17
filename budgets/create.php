
<?php
header('Content-Type: application/json; charset=UTF-8');

include '../connection.php';

$data = json_decode(file_get_contents("php://input"), true);

if (!is_array($data)) {
    echo json_encode([
        'status' => false,
        'message' => 'Invalid request data'
    ]);
    exit;
}

if (
    !isset($data['user_id']) ||
    !isset($data['budget_month']) ||
    !isset($data['amount'])
) {
    echo json_encode([
        'status' => false,
        'message' => 'Required fields missing',
        'received_data' => $data
    ]);
    exit;
}

$res = $cc->common_insert('budgets', $data);

echo json_encode($res);
?>
