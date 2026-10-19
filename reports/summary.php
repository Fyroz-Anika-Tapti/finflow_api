<?php

header('Content-Type: application/json; charset=UTF-8');

include '../connection.php';

$res = [];

try {

    // Total income and expense
    $sql = "
        SELECT
            COALESCE(SUM(
                CASE
                    WHEN LOWER(transaction_type) = 'income'
                    THEN amount ELSE 0
                END
            ), 0) AS total_income,

            COALESCE(SUM(
                CASE
                    WHEN LOWER(transaction_type) = 'expense'
                    THEN amount ELSE 0
                END
            ), 0) AS total_expense

        FROM transactions
        WHERE deleted_at IS NULL
    ";

    $result = $cc->conn->query($sql);

    if (!$result) {
        throw new Exception($cc->conn->error);
    }

    $summary = $result->fetch_assoc();

    $totalIncome = (float) $summary['total_income'];
    $totalExpense = (float) $summary['total_expense'];

    // Current month expense
    $currentMonth = date('Y-m');

    $sql = "
        SELECT COALESCE(SUM(amount), 0) AS total
        FROM transactions
        WHERE LOWER(transaction_type) = 'expense'
        AND deleted_at IS NULL
        AND DATE_FORMAT(transaction_date, '%Y-%m') = '$currentMonth'
    ";

    $result = $cc->conn->query($sql);

    if (!$result) {
        throw new Exception($cc->conn->error);
    }

    $currentExpense = (float) $result->fetch_assoc()['total'];

    // Previous month expense
    $previousMonth = date(
        'Y-m',
        strtotime('first day of last month')
    );

    $sql = "
        SELECT COALESCE(SUM(amount), 0) AS total
        FROM transactions
        WHERE LOWER(transaction_type) = 'expense'
        AND deleted_at IS NULL
        AND DATE_FORMAT(transaction_date, '%Y-%m') = '$previousMonth'
    ";

    $result = $cc->conn->query($sql);

    if (!$result) {
        throw new Exception($cc->conn->error);
    }

    $previousExpense = (float) $result->fetch_assoc()['total'];

    $res = [
        'status' => true,
        'message' => 'Report loaded successfully',
        'data' => [
            'total_income' => $totalIncome,
            'total_expense' => $totalExpense,
            'balance' => $totalIncome - $totalExpense,
            'current_month_expense' => $currentExpense,
            'previous_month_expense' => $previousExpense
        ]
    ];

} catch (Throwable $e) {

    http_response_code(500);

    $res = [
        'status' => false,
        'message' => 'Report load failed'
    ];
}

echo json_encode($res);

?>