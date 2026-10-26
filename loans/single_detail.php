
<?php

include '../connection.php';

$id = filter_input(INPUT_GET, 'id', FILTER_VALIDATE_INT);

if (!$id || $id < 1) {
    http_response_code(400);
    echo json_encode([
        'status' => false,
        'data' => [],
        'message' => 'A valid loan ID is required'
    ]);
    exit;
}

$loanResult = $cc->common_select('loans', '*', ['id' => $id]);

if (!$loanResult['status']) {
    http_response_code(404);
    echo json_encode($loanResult);
    exit;
}

$paymentsResult = $cc->common_query("
    SELECT transaction_details.*
    FROM transaction_details
    INNER JOIN loans
        ON loans.transaction_head_id = transaction_details.transaction_head
    WHERE loans.id = $id
    ORDER BY transaction_details.transaction_date DESC, transaction_details.id DESC
");

echo json_encode([
    'status' => true,
    'data' => [
        'loan' => $loanResult['data'][0],
        'payments' => $paymentsResult['data']
    ],
    'message' => 'Loan details found'
]);
