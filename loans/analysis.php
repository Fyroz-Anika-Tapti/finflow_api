
<?php

include '../connection.php';

header('Content-Type: application/json; charset=utf-8');

try {
    $month_start = date('Y-m-01');
    $next_month_start = date('Y-m-01', strtotime('+1 month'));

    $transaction_result = $cc->common_select('transactions');
$loan_result = $cc->common_select('loans');

$transaction_result = json_decode(json_encode($transaction_result), true);
$loan_result = json_decode(json_encode($loan_result), true);
    $transactions = (
        isset($transaction_result['status']) &&
        $transaction_result['status'] &&
        isset($transaction_result['data']) &&
        is_array($transaction_result['data'])
    ) ? $transaction_result['data'] : [];

    $loans = (
        isset($loan_result['status']) &&
        $loan_result['status'] &&
        isset($loan_result['data']) &&
        is_array($loan_result['data'])
    ) ? $loan_result['data'] : [];

    $monthly_income = 0;
    $monthly_expense = 0;

    // Calculate current month's income and expense
    foreach ($transactions as $transaction) {

        if (
            !empty($transaction['deleted_at']) &&
            $transaction['deleted_at'] !== '0000-00-00 00:00:00'
        ) {
            continue;
        }

        $date = substr(
            $transaction['transaction_date'] ?? '',
            0,
            10
        );

        if ($date < $month_start || $date >= $next_month_start) {
            continue;
        }

        $amount = (float) ($transaction['amount'] ?? 0);

        $type = strtolower(
            trim($transaction['transaction_type'] ?? '')
        );

        if ($type === 'income') {
            $monthly_income += $amount;
        } elseif ($type === 'expense') {
            $monthly_expense += $amount;
        }
    }

    $active_loan_amount = 0;
    $monthly_emi = 0;
    $active_loan_count = 0;
    $loan_list = [];

    // Calculate active loan totals
    foreach ($loans as $loan) {

        if (
            !empty($loan['deleted_at']) &&
            $loan['deleted_at'] !== '0000-00-00 00:00:00'
        ) {
            continue;
        }

        $status = strtolower(
            trim($loan['status'] ?? 'active')
        );

        if (in_array($status, ['completed', 'cancelled', 'closed'])) {
            continue;
        }

        $amount = (float) ($loan['loan_amount'] ?? 0);
        $emi = (float) ($loan['emi_amount'] ?? 0);

        $active_loan_amount += $amount;
        $monthly_emi += $emi;
        $active_loan_count++;

        $loan_list[] = [
            'id' => $loan['id'] ?? null,
            'loan_title' => $loan['loan_title'] ?? 'Untitled Loan',
            'lender_name' => $loan['lender_name'] ?? '',
            'loan_amount' => $amount,
            'interest_rate' => (float) ($loan['interest_rate'] ?? 0),
            'emi_amount' => $emi,
            'status' => $status
        ];
    }

    $surplus_before_emi = $monthly_income - $monthly_expense;
    $remaining_after_emi = $surplus_before_emi - $monthly_emi;

    $emi_ratio = $monthly_income > 0
        ? ($monthly_emi / $monthly_income) * 100
        : null;

    // Risk indicator
    if ($monthly_income <= 0) {
        $risk_level = 'Unknown';
        $risk_message = 'No income recorded for this month.';
    } elseif ($emi_ratio <= 20) {
        $risk_level = 'Low';
        $risk_message = 'EMI is within 20% of monthly income.';
    } elseif ($emi_ratio <= 35) {
        $risk_level = 'Moderate';
        $risk_message = 'EMI takes a moderate share of monthly income.';
    } else {
        $risk_level = 'High';
        $risk_message = 'EMI takes more than 35% of monthly income.';
    }

    // Affordability indicator
    if ($monthly_income <= 0) {
        $affordability = 'Unknown';
        $affordability_message = 'Record income to assess affordability.';
    } elseif ($remaining_after_emi < 0) {
        $affordability = 'Insufficient';
        $affordability_message =
            'Income does not cover recorded expenses and loan EMIs.';
    } else {
        $affordability = 'Positive';
        $affordability_message =
            'Income covers recorded expenses and loan EMIs.';
    }

    echo json_encode([
        'status' => true,
        'message' => 'Loan analysis loaded successfully.',
        'data' => [
            'month' => date('F Y'),
            'monthly_income' => round($monthly_income, 2),
            'monthly_expense' => round($monthly_expense, 2),
            'monthly_surplus_before_emi' => round($surplus_before_emi, 2),
            'active_loan_amount' => round($active_loan_amount, 2),
            'active_loan_count' => $active_loan_count,
            'monthly_emi' => round($monthly_emi, 2),
            'remaining_after_emi' => round($remaining_after_emi, 2),
            'emi_to_income_ratio' => $emi_ratio === null
                ? null
                : round($emi_ratio, 2),
            'risk_level' => $risk_level,
            'risk_message' => $risk_message,
            'affordability' => $affordability,
            'affordability_message' => $affordability_message,
            'loans' => $loan_list
        ]
    ]);

} catch (Throwable $e) {
    http_response_code(500);

    error_log($e->getMessage());

    echo json_encode([
        'status' => false,
        'message' => 'Failed to generate loan analysis.'
    ]);
}