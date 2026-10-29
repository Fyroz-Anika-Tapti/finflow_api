
<?php

include '../connection.php';

header('Content-Type: application/json; charset=utf-8');

$result = $cc->common_select('transactions');

if (isset($result['data']) && is_array($result['data'])) {

    $result['data'] = array_values(array_filter(
        $result['data'],
        function ($transaction) {
            $deletedAt = $transaction['deleted_at']
                ?? $transaction['Deleted_at']
                ?? null;

            return empty($deletedAt);
        }
    ));
}

echo json_encode($result);

?>
