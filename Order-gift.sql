# K) Total unique customers bought vouchers using loan money
SELECT COUNT(DISTINCT a.consumer_id) FROM udio_wallet.dw_transaction a
JOIN udio_wallet.dw_wallet_transaction b on b.txn_code = a.txn_code
WHERE a.transaction_status='success' 
and b.wallet_type_id = 12
AND a.txn_type_code IN ('OG')
AND a.created_date >='2019-07-22 00:00:00' AND a.created_date < CURDATE();

# L) Total amount for customers who bought vouchers using loan money
SELECT SUM(a.amount) FROM udio_wallet.dw_transaction a
JOIN udio_wallet.dw_wallet_transaction b on b.txn_code = a.txn_code
WHERE a.transaction_status='success' 
and b.wallet_type_id = 12
AND a.txn_type_code IN ('OG')
AND a.created_date >='2019-07-22 00:00:00' AND a.created_date < CURDATE();

SELECT * FROM udio_wallet.dgv_merchant_brand ORDER BY ID DESC;
SELECT * from udio_wallet.dgv_user_voucher ORDER BY id DESC;
SELECT * from udio_wallet.dgv_voucher_repo ORDER BY id DESC;
SELECT * from udio_wallet.dgv_brand ORDER BY id DESC;
select * from udio_wallet.dgc_card_master order by id desc limit 10;
select * from udio_wallet.dw_gift_transaction;

select * from udio_wallet.dw_gift_transaction gt
inner join udio_wallet.dw_wallet_transaction wt
on gt.sender_consumer_id = wt.consumer_id and gt.txn_code = wt.txn_code
where gt.status = 'success'
and gt.sender_consumer_id in (
SELECT
count(b.mobile_number), sum(a.amount) from udio_wallet.dw_transaction a
JOIN udio_wallet.dw_wallet_transaction wt on wt.txn_code = a.txn_code and a.consumer_id=wt.consumer_id
JOIN udio_wallet.dw_user_wallet uw on uw.id = wt.user_wallet_id
INNER JOIN udio_wallet.b2c_user b
ON a.consumer_id = b.consumer_id
and a.transaction_status='success'
and a.txn_type_code = 'mcd'
and a.txn_mode = 'cr'
and a.merchant_id = 40006939
and uw.wallet_type_id = 12
and a.amount >=1000
AND a.txn_refnum like ('%TP%')
and a.transaction_date >= "2019-05-01 00:00:00" and a.transaction_date < CURDATE()
)
and wt.wallet_type_id = 12;

select brand_uid,status,count(voucher_code),expiry_date,denomination from udio_wallet.dgv_voucher_repo where status='free' group by 1,2,5;

