############# DGD all GOLD TRANSACTIONS
select * from udio_wallet.dgd_transaction dg
INNER JOIN udio_wallet.b2c_user b
on b.mobile_number = dg.mobile_number
where dg.status='success'
and dg.transaction_date >= '2019-07-01 00:00:00' and dg.transaction_date <= '2019-07-30 23:59:59'
and dg.source_id=1111
and b.product_id=2;

############# DGD all GOLD TRANSACTIONS
select dg.payment_mode as 'Payment Mode', dg.action as 'Action', round(sum(dg.txn_amount),0) as 'Total Amount', round(sum(dg.gold_in_grams),2) as 'Gold in grams', COUNT(DISTINCT dg.mobile_number) as 'No. of Users', round((sum(dg.txn_amount))/(COUNT(DISTINCT dg.mobile_number)),0) as 'Avg. Ticket size per User' from udio_wallet.dgd_transaction dg
INNER JOIN udio_wallet.b2c_user b
on b.mobile_number = dg.mobile_number
where dg.status='success'
and dg.transaction_date >= '2019-07-01 00:00:00' and dg.transaction_date <= '2019-07-30 23:59:59'
and dg.source_id=1111
and b.product_id=2
group by dg.payment_mode, dg.action;

############# DGD all GOLD TRANSACTIONS with payment through wallet = all these enteries are there in transaction table
select round(sum(dg.txn_amount),0) as 'Total Amount', round(sum(dg.gold_in_grams),2) as 'Gold in grams', COUNT(DISTINCT dg.mobile_number) as 'No. of Users', round((sum(dg.txn_amount))/(COUNT(DISTINCT dg.mobile_number)),0) as 'Avg. Ticket size per User' from udio_wallet.dgd_transaction dg
INNER JOIN udio_wallet.b2c_user b
on b.mobile_number = dg.mobile_number
where dg.status='success'
and dg.transaction_date >= '2019-07-01 00:00:00' and dg.transaction_date <= '2019-07-30 23:59:59'
and dg.source_id=1111
and b.product_id=2
and dg.payment_mode='wallet';



############# DGD all GOLD TRANSACTIONS with payment through PG (payment gateway)
select round(sum(dg.txn_amount),0) as 'Total Amount', round(sum(dg.gold_in_grams),2) as 'Gold in grams', COUNT(dg.txn_refnum) as 'No. of Transactions', round(avg(dg.txn_amount),0) as 'Avg. Ticket size per Transaction', COUNT(DISTINCT dg.mobile_number) as 'No. of Users', round((sum(dg.txn_amount))/(COUNT(DISTINCT dg.mobile_number)),0) as 'Avg. Ticket size per User' from udio_wallet.dgd_transaction dg
INNER JOIN udio_wallet.b2c_user b
on b.mobile_number = dg.mobile_number
where dg.status='success'
and dg.transaction_date >= '2019-07-01 00:00:00' and dg.transaction_date <= '2019-07-30 23:59:59'
and dg.source_id=1111
and b.product_id=2
and dg.payment_mode='pg';



############# DT all GOLD TRANSACTIONS
select round(sum(amount),0) as 'Total Amount' from udio_wallet.dw_transaction dt 
where txn_type_code='GOLD'
AND transaction_status='success'
AND product_id=2
and transaction_date >= '2019-07-01 00:00:00' and transaction_date <= '2019-07-30 23:59:59';




############# WT all GOLD BUY TRANSACTIONS count and avg ticket size
select round(sum(wt.amount),0) as 'Total Amount', count(wt.txn_code) as 'No. of Transactions', round(avg(wt.amount),0) as 'Avg. Ticket size per Transaction' from udio_wallet.dw_wallet_transaction wt
inner JOIN udio_wallet.dw_transaction dt
on dt.consumer_id = wt.consumer_id and wt.txn_code = dt.txn_code
inner join udio_wallet.dgd_transaction dg 
on dt.consumer_id = dg.consumer_id and dt.txn_refnum = dg.txn_code
where dt.txn_type_code='GOLD'
AND dt.transaction_status='success'
AND dt.product_id=2
and dt.transaction_date >= '2019-07-01 00:00:00' and dt.transaction_date <= '2019-07-30 23:59:59';


############# WT all GOLD BUY TRANSACTIONS with wallet type id
select wt.wallet_type_id, round(sum(wt.amount),0) as 'Total Amount', count(wt.txn_code) as 'No. of Transactions', round(avg(wt.amount),0) as 'Avg. Ticket size per Transaction', COUNT(DISTINCT wt.consumer_id) as 'No. of Users', round(sum(wt.amount)/COUNT(DISTINCT wt.consumer_id),0) as 'Avg. Ticket size per User' from udio_wallet.dw_wallet_transaction wt
inner JOIN udio_wallet.dw_transaction dt
on dt.consumer_id = wt.consumer_id and wt.txn_code = dt.txn_code
inner join udio_wallet.dgd_transaction dg 
on dt.consumer_id = dg.consumer_id and dt.txn_refnum = dg.txn_code
where dt.txn_type_code='GOLD'
AND dt.transaction_status='success'
AND dt.product_id=2
and dt.transaction_date >= '2019-07-01 00:00:00' and dt.transaction_date <= '2019-07-30 23:59:59'
group by wt.wallet_type_id;




#### All PG buy = transaction type
select  b.payment_type AS 'Payment Type', round(sum(dg.txn_amount),0) as 'Total Amount', round(SUM(dg.gold_in_grams),2) as 'Gold in grams',  count(dg.txn_code) as 'No. of Transactions', round(avg(txn_amount),0) as 'Avg. Ticket size per Transaction', count(DISTINCT dg.mobile_number) as 'No. of Users', round(sum(txn_amount)/count(DISTINCT dg.mobile_number),0) as 'Avg. Ticket size per User' from udio_wallet.dgd_transaction dg
inner join transerv_db.pg_init_transaction a
on a.mobile_no = dg.mobile_number and a.merchant_ref_id = dg.txn_code
inner join transerv_db.pg_payment_transaction b
on b.mobile_no = a.mobile_no and b.udio_ref_id = a.udio_ref_id
inner join udio_wallet.b2c_user u
on u.mobile_number = dg.mobile_number
where dg.status='success'
and dg.transaction_date >= '2019-07-01 00:00:00' and dg.transaction_date <= '2019-07-30 23:59:59'
and dg.source_id=1111
and dg.payment_mode='pg'
and u.product_id=2
group by b.payment_type;


select (
CASE
WHEN b.payment_type='CC' THEN 'CREDIT CARD'
WHEN b.payment_type='DB' THEN 'DEBIT CARD'
WHEN b.payment_type='NB' THEN 'NET BANKING'
END
) AS 'Payment Type', round(sum(dg.txn_amount),0), count(DISTINCT dg.mobile_number), count(dg.txn_code), round(SUM(dg.gold_in_grams),2) from udio_wallet.dgd_transaction dg
inner join transerv_db.pg_init_transaction a
on a.mobile_no = dg.mobile_number and a.merchant_ref_id = dg.txn_code
inner join transerv_db.pg_payment_transaction b
on b.mobile_no = a.mobile_no and b.udio_ref_id = a.udio_ref_id
inner join udio_wallet.b2c_user u
on u.mobile_number = dg.mobile_number
where dg.status='success'
and dg.transaction_date >= '2019-07-01 00:00:00' and dg.transaction_date <= '2019-07-30 23:59:59'
and dg.source_id=1111
and dg.payment_mode='pg'
and u.product_id=2
group by b.payment_type;





#### Udio Treats
select * FROM udio_wallet.dw_payout_request where merchant_id='40006964'

select b.mobile_number,a.amount,a.updated_date from udio_wallet.dw_transaction a
INNER JOIN udio_wallet.b2c_user b
ON a.consumer_id = b.consumer_id
where a.merchant_id='40006964'
and b.product_id=2
and a.txn_mode='cr'
and a.transaction_status='success';



########## Daily Gold BUY Amount
select DATE_FORMAT(dg.transaction_date,'%d-%M-%Y') AS 'Transaction Date', round(sum(dg.txn_amount),0) as 'Sell Amount', count(DISTINCT dg.mobile_number) as 'No. of Users' from udio_wallet.dgd_transaction dg
INNER JOIN udio_wallet.b2c_user b
on b.mobile_number = dg.mobile_number
where dg.status='success'
and dg.transaction_date >= '2019-07-01 00:00:00' and dg.transaction_date <= '2019-07-30 23:59:59'
and dg.source_id=1111
and b.product_id=2
and dg.payment_mode='wallet'
and dg.action='buy'
GROUP by 1;


########## Daily Gold SELL Amount
select DATE_FORMAT(dg.transaction_date,'%d-%M-%Y') AS 'Transaction Date', round(sum(dg.txn_amount),0) as 'Sell Amount', count(DISTINCT dg.mobile_number) as 'No. of Users' from udio_wallet.dgd_transaction dg
INNER JOIN udio_wallet.b2c_user b
on b.mobile_number = dg.mobile_number
where dg.status='success'
and dg.transaction_date >= '2019-07-01 00:00:00' and dg.transaction_date <= '2019-07-30 23:59:59'
and dg.source_id=1111
and b.product_id=2
and dg.action='sell'
GROUP by 1;


########## GOLD SOLD BY BUYERS
SELECT sum(txn_amount), sum(gold_in_grams), count(DISTINCT mobile_number), count(txn_refnum) from udio_wallet.dgd_transaction
where status='success'
and source_id=1111
and action='sell'
and transaction_date >= '2019-07-01 00:00:00' and transaction_date <= '2019-07-30 23:59:59'
and mobile_number in (
select DISTINCT dg.mobile_number from udio_wallet.dgd_transaction dg
INNER JOIN udio_wallet.b2c_user b
on b.mobile_number = dg.mobile_number
where dg.status='success'
and dg.transaction_date >= '2019-07-01 00:00:00' and dg.transaction_date <= '2019-07-30 23:59:59'
and dg.source_id=1111
and b.product_id=2
and dg.action='buy'
);

