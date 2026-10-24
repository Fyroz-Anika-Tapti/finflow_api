<?php
header('Content-Type: application/json; charset=UTF-8');

include '../connection.php';

try {
    // আপাতত তোমার project-এর existing user_id = 1 অনুযায়ী
    // কাজ করবে। পরে logged-in user-এর ID ব্যবহার করবে।
    $user_id = 1;

    // 1. Total Income এবং Expense
    $sql = "SELECT
        COALESCE(SUM(
            CASE WHEN LOWER(transaction_type) = 'income'
            THEN amount ELSE 0 END
        ), 0) AS total_income,

        COALESCE(SUM(
            CASE WHEN LOWER(transaction_type) = 'expense'
            THEN amount ELSE 0 END
        ), 0) AS total_expense

        FROM transactions
        WHERE user_id = $user_id
        AND deleted_at IS NULL";

    $result = $cc->conn->query($sql);

    if (!$result) {
        throw new Exception('Transaction summary query failed');
    }

    $summary = $result->fetch_assoc();

    $total_income = (float)$summary['total_income'];
    $total_expense = (float)$summary['total_expense'];
    $balance = $total_income - $total_expense;

    // 2. Total Savings
    $sqlSavings = "SELECT
        COALESCE(SUM(saved_amount), 0) AS total_savings,
        COUNT(*) AS total_goals
        FROM savings_goals
        WHERE user_id = $user_id
        AND deleted_at IS NULL";

    $savingsResult = $cc->conn->query($sqlSavings);

    if (!$savingsResult) {
        throw new Exception('Savings query failed');
    }

    $savings = $savingsResult->fetch_assoc();

    // 3. Recent Transactions
    $sqlRecent = "SELECT
        id,
        purpose,
        transaction_type,
        amount,
        transaction_date
        FROM transactions
        WHERE user_id = $user_id
        AND deleted_at IS NULL
        ORDER BY transaction_date DESC, id DESC
        LIMIT 5";

    $recentResult = $cc->conn->query($sqlRecent);

    if (!$recentResult) {
        throw new Exception('Recent transactions query failed');
    }

    $recent_transactions = [];

    while ($row = $recentResult->fetch_assoc()) {
        $row['amount'] = (float)$row['amount'];
        $recent_transactions[] = $row;
    }

    // 4. Last 6 months income and expense
    $sqlMonthly = "SELECT
        DATE_FORMAT(transaction_date, '%Y-%m') AS month_key,
        DATE_FORMAT(transaction_date, '%b %Y') AS month_name,

        COALESCE(SUM(
            CASE WHEN LOWER(transaction_type) = 'income'
            THEN amount ELSE 0 END
        ), 0) AS income,

        COALESCE(SUM(
            CASE WHEN LOWER(transaction_type) = 'expense'
            THEN amount ELSE 0 END
        ), 0) AS expense

        FROM transactions
        WHERE user_id = $user_id
        AND deleted_at IS NULL
        AND transaction_date >= DATE_FORMAT(
            DATE_SUB(CURDATE(), INTERVAL 5 MONTH), '%Y-%m-01'
        )
        AND transaction_date <= CURDATE()

        GROUP BY month_key, month_name
        ORDER BY month_key ASC";

    $monthlyResult = $cc->conn->query($sqlMonthly);

    if (!$monthlyResult) {
        throw new Exception('Monthly overview query failed');
    }

    $monthly_overview = [];

    while ($row = $monthlyResult->fetch_assoc()) {
        $monthly_overview[] = [
            'month_key' => $row['month_key'],
            'month_name' => $row['month_name'],
            'income' => (float)$row['income'],
            'expense' => (float)$row['expense']
        ];
    }

    echo json_encode([
        'status' => true,
        'message' => 'Dashboard data loaded successfully',
        'data' => [
            'total_income' => $total_income,
            'total_expense' => $total_expense,
            'balance' => $balance,
            'total_savings' => (float)$savings['total_savings'],
            'total_goals' => (int)$savings['total_goals'],
            'recent_transactions' => $recent_transactions,
            'monthly_overview' => $monthly_overview
        ]
    ]);

} catch (Throwable $e) {
    http_response_code(500);

    echo json_encode([
        'status' => false,
        'message' => 'Dashboard data load failed'
    ]);
}
?>