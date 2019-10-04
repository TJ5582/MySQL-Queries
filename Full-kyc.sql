### Loans dsibursed in loan purse

select DISTINCT b.mobile_number from udio_wallet.dw_kyc_application a
inner join udio_wallet.dw_ppi_bank_user b
on a.mobile_number = b.mobile_number and b.ppi_bank_id=2
where b.status='active' and b.kyc_level='full_kyc'
and a.payment_status='paid'
and a.status IN ('verified')
and a.consumer_id NOT IN (
SELECT DISTINCT dt.consumer_id
FROM udio_wallet.dw_transaction dt
WHERE dt.product_id=2 AND dt.merchant_id in (40006939,40006976) AND dt.txn_mode='cr'
AND dt.transaction_status='success'
AND (dt.txn_refnum like ('%PL%') or dt.txn_refnum like ('%TP%')))


select COUNT(DISTINCT a.consumer_id) from udio_wallet.dw_kyc_application a
inner join udio_wallet.dw_ppi_bank_user b
on a.mobile_number = b.mobile_number and b.ppi_bank_id=2
where b.status='active' and b.kyc_level='full_kyc'
and a.payment_status='paid'
and a.status IN ('verified');



select *, wt.wallet_type_id from udio_wallet.dw_transaction a
JOIN udio_wallet.dw_wallet_transaction wt
on wt.txn_code = a.txn_code and a.consumer_id = wt.consumer_id and a.transaction_status = wt.status
where a.consumer_id in (
select a.consumer_id from udio_wallet.dw_kyc_application a
inner join udio_wallet.dw_ppi_bank_user b
on a.mobile_number = b.mobile_number and b.ppi_bank_id=2
where b.status='active' and b.kyc_level='full_kyc'
and a.payment_status='paid'
and a.status IN ('verified')
)
and a.transaction_status='success'
AND a.txn_mode='dr'
and a.product_id=2
and a.merchant_id=1111
and a.transaction_date >= '2019-07-01 00:00:00' and a.transaction_date <= '2019-07-31 23:59:59';




select * from udio_wallet.dw_kyc_application where mobile_number='';
select * from udio_wallet.b2c_user where mobile_number='' and product_id=2;
select * from udio_wallet.dw_ppi_bank_user where mobile_number='';




################ NON-LOAN FULL KYC ALL TRANSACTIONS FROM DW_TRANSACTIONS TABLE
select * from udio_wallet.dw_transaction a
where consumer_id in (
select DISTINCT a.consumer_id from udio_wallet.dw_kyc_application a
inner join udio_wallet.dw_ppi_bank_user b
on a.mobile_number = b.mobile_number and b.ppi_bank_id=2
where b.status='active' and b.kyc_level='full_kyc'
and a.payment_status='paid'
and a.status IN ('verified')
and a.consumer_id NOT IN (
SELECT DISTINCT dt.consumer_id
FROM udio_wallet.dw_transaction dt
WHERE dt.product_id=2 AND dt.merchant_id in (40006939,40006976) AND dt.txn_mode='cr'
AND dt.transaction_status='success'
AND (dt.txn_refnum like ('%PL%') or dt.txn_refnum like ('%TP%')))
)
and transaction_status='success'
AND txn_mode='dr'
and product_id=2
and merchant_id=1111
and transaction_date >= '2019-07-01 00:00:00' and transaction_date <= '2019-07-31 23:59:59';


################ FULL KYC ALL TRANSACTIONS

select
a.txn_type_code,
sum(wt.amount) as "Amount",
COUNT(DISTINCT a.consumer_id) as "No. of Unique Customer",
count(wt.txn_code) as "No. of transactions"
from udio_wallet.dw_transaction a
JOIN udio_wallet.dw_wallet_transaction wt
on wt.txn_code = a.txn_code and a.consumer_id = wt.consumer_id and a.transaction_status = wt.status
where a.consumer_id in (
select DISTINCT a.consumer_id from udio_wallet.dw_kyc_application a
inner join udio_wallet.dw_ppi_bank_user b
on a.mobile_number = b.mobile_number and b.ppi_bank_id=2
where b.status='active' and b.kyc_level='full_kyc'
and a.payment_status='paid'
and a.status IN ('verified')
)
and a.transaction_status='success'
AND a.txn_mode='dr'
and a.product_id=2
and a.merchant_id=1111
and a.transaction_date >= '2019-07-01 00:00:00' and a.transaction_date <= '2019-07-31 23:59:59'
GROUP by a.txn_type_code;


################ FULL KYC NON-LOAN DISBURSED ALL TRANSACTIONS PIVOT

select
a.txn_type_code,
sum(wt.amount) as "Amount",
COUNT(DISTINCT a.consumer_id) as "No. of Unique Customer",
count(wt.txn_code) as "No. of transactions"
from udio_wallet.dw_transaction a
JOIN udio_wallet.dw_wallet_transaction wt
on wt.txn_code = a.txn_code and a.consumer_id = wt.consumer_id and a.transaction_status = wt.status
where a.consumer_id in (
select DISTINCT a.consumer_id from udio_wallet.dw_kyc_application a
inner join udio_wallet.dw_ppi_bank_user b
on a.mobile_number = b.mobile_number and b.ppi_bank_id=2
where b.status='active' and b.kyc_level='full_kyc'
and a.payment_status='paid'
and a.status IN ('verified')
and a.consumer_id NOT IN (
SELECT DISTINCT dt.consumer_id
FROM udio_wallet.dw_transaction dt
WHERE dt.product_id=2 AND dt.merchant_id in (40006939,40006976) AND dt.txn_mode='cr'
AND dt.transaction_status='success'
AND (dt.txn_refnum like ('%PL%') or dt.txn_refnum like ('%TP%')))
)
and a.transaction_status='success'
AND a.txn_mode='dr'
and a.product_id=2
and a.merchant_id=1111
and a.transaction_date >= '2019-07-01 00:00:00' and a.transaction_date <= '2019-07-31 23:59:59'
GROUP by a.txn_type_code;



################ FULL KYC NON-LOAN DISBURSED = Card TRANSACTION


SELECT 
a.narration as "Merchant Name",
sum(a.transaction_amount) as "Amount",
count(a.txn_code) as "No. of Transactions",
a.txn_type as "Transaction Type",
count(DISTINCT a.consumer_id) "Distinct Users"
from udio_wallet.dw_card_transaction a
INNER JOIN udio_wallet.dw_transaction b
on a.txn_code = b.txn_code and a.consumer_id=b.consumer_id and a.status = b.transaction_status and b.product_id=2
where b.txn_type_code='CT'
AND a.status='success'
AND b.txn_mode='dr'
AND b.product_id='2'
and b.transaction_date >= '2019-07-01 00:00:00' and b.transaction_date <= '2019-07-31 23:59:59'
AND a.consumer_id IN (
select DISTINCT a.consumer_id from udio_wallet.dw_kyc_application a
inner join udio_wallet.dw_ppi_bank_user b
on a.mobile_number = b.mobile_number and b.ppi_bank_id=2
where b.status='active' and b.kyc_level='full_kyc'
and a.payment_status='paid'
and a.status IN ('verified')
and a.consumer_id NOT IN (
SELECT DISTINCT dt.consumer_id
FROM udio_wallet.dw_transaction dt
WHERE dt.product_id=2 AND dt.merchant_id in (40006939,40006976) AND dt.txn_mode='cr'
AND dt.transaction_status='success'
AND (dt.txn_refnum like ('%PL%') or dt.txn_refnum like ('%TP%')))
)
group by 1
order by 2 DESC;


################ FULL KYC NON-LOAN DISBURSED = Card TRANSACTION = PIVOT

SELECT 
a.txn_type as "Transaction Type",
sum(a.transaction_amount) as "Amount",
count(a.txn_code) as "No. of Transactions",
count(DISTINCT a.consumer_id) "Distinct Users"
from udio_wallet.dw_card_transaction a
INNER JOIN udio_wallet.dw_transaction b
on a.txn_code = b.txn_code and a.consumer_id=b.consumer_id and a.status = b.transaction_status and b.product_id=2
where b.txn_type_code='CT'
AND a.status='success'
AND b.txn_mode='dr'
AND b.product_id='2'
and b.transaction_date >= '2019-07-01 00:00:00' and b.transaction_date <= '2019-07-31 23:59:59'
AND a.consumer_id IN (
select DISTINCT a.consumer_id from udio_wallet.dw_kyc_application a
inner join udio_wallet.dw_ppi_bank_user b
on a.mobile_number = b.mobile_number and b.ppi_bank_id=2
where b.status='active' and b.kyc_level='full_kyc'
and a.payment_status='paid'
and a.status IN ('verified')
and a.consumer_id NOT IN (
SELECT DISTINCT dt.consumer_id
FROM udio_wallet.dw_transaction dt
WHERE dt.product_id=2 AND dt.merchant_id in (40006939,40006976) AND dt.txn_mode='cr'
AND dt.transaction_status='success'
AND (dt.txn_refnum like ('%PL%') or dt.txn_refnum like ('%TP%')))
)
group by 1;


################ FULL KYC NON-LOAN DISBURSED = Recharge

SELECT a.operator_type as "Operator Type",
a.recharge_type as "Recharge Type",
a.operator as "Operator",
a.transaction_status as "Transaction Status",
sum(a.amount) as "Amount",
count(a.txn_code) as "No. of Transactions",
count(DISTINCT a.consumer_id) "Distinct Users"
from udio_wallet.dw_recharge_transaction a
INNER JOIN udio_wallet.dw_transaction b
on a.txn_code = b.txn_code and a.consumer_id=b.consumer_id and a.transaction_status = b.transaction_status and b.product_id=2
where a.transaction_status='success'
and b.product_id=2
and a.transaction_date >= '2019-07-01 00:00:00' and a.transaction_date <= '2019-07-31 23:59:59'
AND a.consumer_id IN (
select DISTINCT a.consumer_id from udio_wallet.dw_kyc_application a
inner join udio_wallet.dw_ppi_bank_user b
on a.mobile_number = b.mobile_number and b.ppi_bank_id=2
where b.status='active' and b.kyc_level='full_kyc'
and a.payment_status='paid'
and a.status IN ('verified')
and a.consumer_id NOT IN (
SELECT DISTINCT dt.consumer_id
FROM udio_wallet.dw_transaction dt
WHERE dt.product_id=2 AND dt.merchant_id in (40006939,40006976) AND dt.txn_mode='cr'
AND dt.transaction_status='success'
AND (dt.txn_refnum like ('%PL%') or dt.txn_refnum like ('%TP%')))
)
group by a.operator;




################ FULL KYC NON-LOAN DISBURSED = Bill Payment Transaction = None for july

SELECT a.provider as 'Provider',
a.provider_type  as 'Provider Type',
sum(a.amount) as 'Amount',
count(a.txn_code) as 'No. of Transactions'
from udio_wallet.dw_bill_payment_transaction a
INNER JOIN udio_wallet.dw_transaction b
on a.txn_code = b.txn_code and a.consumer_id=b.consumer_id and a.transaction_status = b.transaction_status and b.product_id=2
where a.transaction_status='success'
and b.product_id=2
and a.transaction_date >= '2019-07-01 00:00:00' and a.transaction_date <= '2019-07-31 23:59:59'
AND a.consumer_id IN (
select DISTINCT a.consumer_id from udio_wallet.dw_kyc_application a
inner join udio_wallet.dw_ppi_bank_user b
on a.mobile_number = b.mobile_number and b.ppi_bank_id=2
where b.status='active' and b.kyc_level='full_kyc'
and a.payment_status='paid'
and a.status IN ('verified')
and a.consumer_id NOT IN (
SELECT DISTINCT dt.consumer_id
FROM udio_wallet.dw_transaction dt
WHERE dt.product_id=2 AND dt.merchant_id in (40006939,40006976) AND dt.txn_mode='cr'
AND dt.transaction_status='success'
AND (dt.txn_refnum like ('%PL%') or dt.txn_refnum like ('%TP%')))
)
group by 1;



#### User Loan Wallet Balance

select count(DISTINCT a.consumer_id) as "Users",
sum(a.balance) as "Wal_Balance"
from udio_wallet.dw_user_wallet a
where a.consumer_id IN (
select DISTINCT a.consumer_id from udio_wallet.dw_kyc_application a
inner join udio_wallet.dw_ppi_bank_user b
on a.mobile_number = b.mobile_number and b.ppi_bank_id=2
where b.status='active' and b.kyc_level='full_kyc'
and a.payment_status='paid'
and a.status IN ('verified')
and a.consumer_id NOT IN (
SELECT DISTINCT dt.consumer_id
FROM udio_wallet.dw_transaction dt
WHERE dt.product_id=2 AND dt.merchant_id in (40006939,40006976) AND dt.txn_mode='cr'
AND dt.transaction_status='success'
AND (dt.txn_refnum like ('%PL%') or dt.txn_refnum like ('%TP%')))
)
and a.product_id='2'
and a.status='active';

