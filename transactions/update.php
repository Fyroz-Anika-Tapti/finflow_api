<?php

include '../connection.php';

$id = $_GET['id'] ?? null;
$res = [
    'status' => false,
    'data' => [],
    'message' => 'Invalid request'
];

if ($id && isset($_POST['transaction_date'])) {
    $data = [
        'amount' => $_POST['gross_amount'],
        'transaction_date' => $_POST['transaction_date'],
        'transaction_type' => $_POST['transaction_type'],
        'purpose' => $_POST['purpose'],
        'updated_at' => date('Y-m-d H:i:s'),
        'user_id' => 1
    ];

    $res = $cc->common_update('transactions', $data, ['id' => $id]);

    if ($res['status']) {
        $cc->common_delete('transaction_details', ['transaction_id' => $id]);

        if ($_POST['transaction_type'] === 'income') {
            $dr_row['transaction_id'] = $id;
            $dr_row['transaction_head'] = $_POST['transaction_head'];
            $dr_row['transaction_date'] = $_POST['transaction_date'];
            $dr_row['dr'] = $_POST['gross_amount'];
            $dr_row['purpose'] = $_POST['purpose'];
            $dr_row['created_at'] = date('Y-m-d H:i:s');
            $cc->common_insert('transaction_details', $dr_row);

            if (isset($_POST['gt']) && is_array($_POST['gt'])) {
                foreach ($_POST['gt'] as $gt_row) {
                    $cr_row['transaction_id'] = $id;
                    $cr_row['transaction_date'] = $_POST['transaction_date'];
                    $cr_row['transaction_head'] = $gt_row['transaction_head'];
                    $cr_row['purpose'] = $gt_row['note'];
                    $cr_row['cr'] = $gt_row['amount'];
                    $cr_row['created_at'] = date('Y-m-d H:i:s');
                    $cc->common_insert('transaction_details', $cr_row);
                }
            }
        }

        if ($_POST['transaction_type'] === 'expense') {
            $cr_row['transaction_id'] = $id;
            $cr_row['transaction_head'] = $_POST['transaction_head'];
            $cr_row['transaction_date'] = $_POST['transaction_date'];
            $cr_row['cr'] = $_POST['gross_amount'];
            $cr_row['purpose'] = $_POST['purpose'];
            $cr_row['created_at'] = date('Y-m-d H:i:s');
            $cc->common_insert('transaction_details', $cr_row);

            if (isset($_POST['gt']) && is_array($_POST['gt'])) {
                foreach ($_POST['gt'] as $gt_row) {
                    $dr_row['transaction_id'] = $id;
                    $dr_row['transaction_date'] = $_POST['transaction_date'];
                    $dr_row['transaction_head'] = $gt_row['transaction_head'];
                    $dr_row['purpose'] = $gt_row['note'];
                    $dr_row['dr'] = $gt_row['amount'];
                    $dr_row['created_at'] = date('Y-m-d H:i:s');
                    $cc->common_insert('transaction_details', $dr_row);
                }
            }
        }
    }
}

echo json_encode($res);

