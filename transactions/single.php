<?php

include '../connection.php';

$id = $_GET['id'] ?? null;

$result = [
    'status' => false,
    'data' => [],
    'message' => 'Transaction not found'
];

if (!$id) {
    echo json_encode($result);
    exit;
}

$transaction = $cc->common_select(
    'transactions',
    '*',
    ['id' => $id]
);

if (!$transaction['status']) {
    echo json_encode($transaction);
    exit;
}

$transactionData = $transaction['data'][0];
$details = $cc->common_select(
    'transaction_details',
    '*',
    ['transaction_id' => $id],
    'AND',
    'id',
    'ASC'
);

$mainTransactionHead = '';
$groupTransactions = [];
$grossAmount = property_exists($transactionData, 'amount') ? $transactionData->amount : 0;

if ($details['status']) {
    foreach ($details['data'] as $detail) {
        $detailObj = (object) $detail;

        $detailHead = property_exists($detailObj, 'transaction_head') ? $detailObj->transaction_head : '';
        $detailPurpose = property_exists($detailObj, 'purpose') ? $detailObj->purpose : '';
        $detailDr = property_exists($detailObj, 'dr') ? floatval($detailObj->dr) : 0;
        $detailCr = property_exists($detailObj, 'cr') ? floatval($detailObj->cr) : 0;

        if (
            property_exists($transactionData, 'transaction_type') &&
            (($transactionData->transaction_type === 'income' && $detailDr > 0 && floatval($grossAmount) == $detailDr) ||
            ($transactionData->transaction_type === 'expense' && $detailCr > 0 && floatval($grossAmount) == $detailCr))
        ) {
            $mainTransactionHead = $detailHead;
            continue;
        }

        if ($detailCr > 0 || $detailDr > 0) {
            $groupTransactions[] = [
                'transaction_head' => $detailHead,
                'amount' => ($detailDr > 0 ? $detailDr : $detailCr),
                'note' => $detailPurpose,
            ];
        }
    }
}

$formattedTransaction = [
    'id' => property_exists($transactionData, 'id') ? $transactionData->id : $id,
    'transaction_type' => property_exists($transactionData, 'transaction_type') ? $transactionData->transaction_type : '',
    'purpose' => property_exists($transactionData, 'purpose') ? $transactionData->purpose : '',
    'transaction_head' => $mainTransactionHead,
    'transaction_date' => property_exists($transactionData, 'transaction_date') ? $transactionData->transaction_date : '',
    'gross_amount' => $grossAmount,
    'group_transctions' => $groupTransactions,
];

$result = [
    'status' => true,
    'data' => [$formattedTransaction],
    'message' => 'Transaction found'
];

echo json_encode($result);