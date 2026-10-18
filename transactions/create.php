<?php

include '../connection.php';

$res = [];

if (isset($_POST['transaction_date'])) {

        $data['amount'] = $_POST['gross_amount'];
        $data['transaction_date'] = $_POST['transaction_date'];
        $data['transaction_type'] = $_POST['transaction_type'];
        $data['purpose'] = $_POST['purpose'];
        $data['created_at'] = date('Y-m-d H:i:s');
        $data['user_id'] = 1;
        $res = $cc->common_insert('transactions', $data);
        if($res['status']) {
            $transaction_id = $res['data'];

            if($_POST['transaction_type'] === 'income') {
                $dr_row['transaction_id'] = $transaction_id;
                $dr_row['transaction_head'] = $_POST['transaction_head'];
                $dr_row['transaction_date'] = $_POST['transaction_date'];
                $dr_row['dr'] = $_POST['gross_amount'];
                $dr_row['purpose'] = $_POST['purpose'];
                $dr_row['created_at'] = date('Y-m-d H:i:s');
                $ress = $cc->common_insert('transaction_details', $dr_row);

                foreach($_POST['gt'] as $gt_row) {
                    $cr_row['transaction_id'] = $transaction_id;
                    $cr_row['transaction_date'] = $_POST['transaction_date'];
                    $cr_row['transaction_head'] = $gt_row['transaction_head'];
                    $cr_row['purpose'] = $gt_row['note'];
                    $cr_row['cr'] = $gt_row['amount'];
                    $cr_row['created_at'] = date('Y-m-d H:i:s');
                    $ress = $cc->common_insert('transaction_details', $cr_row);
                }
            }elseif($_POST['transaction_type'] === 'expense') {
                $exp_row['transaction_id'] = $transaction_id;
                $exp_row['transaction_head'] = $_POST['transaction_head'];
                $exp_row['transaction_date'] = $_POST['transaction_date'];
                $exp_row['cr'] = $_POST['gross_amount'];
                $exp_row['purpose'] = $_POST['purpose'];
                $exp_row['created_at'] = date('Y-m-d H:i:s');
                $ress = $cc->common_insert('transaction_details', $exp_row);

                

                foreach($_POST['gt'] as $gt_row) {
                    $cr_row['transaction_id'] = $transaction_id;
                    $cr_row['transaction_date'] = $_POST['transaction_date'];
                    $cr_row['transaction_head'] = $gt_row['transaction_head'];
                    $cr_row['purpose'] = $gt_row['note'];
                    $cr_row['dr'] = $gt_row['amount'];
                    $cr_row['created_at'] = date('Y-m-d H:i:s');
                    $ress = $cc->common_insert('transaction_details', $cr_row);
                }
            }
        }

}

echo json_encode($res);