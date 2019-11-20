############### TOTAL LOAN DISBURSED (TOP-UP + CHOTA CREDIT)

SELECT COUNT(u.mobile_number), SUM(dt.amount)
FROM udio_wallet.b2c_user u
JOIN udio_wallet.dw_transaction dt ON dt.consumer_id=u.consumer_id
WHERE u.product_id=2 AND dt.merchant_id in (40006939,40006976) AND dt.txn_mode='cr'
AND dt.transaction_status='success'
AND (dt.txn_refnum like ('%PL%') or dt.txn_refnum like ('%TP%'))
AND dt.transaction_date < CURDATE();


SELECT COUNT(u.mobile_number) as "Total Users", SUM(dt.amount) as "Total Amount"
FROM udio_wallet.b2c_user u
JOIN udio_wallet.dw_transaction dt ON dt.consumer_id=u.consumer_id
JOIN udio_wallet.dw_wallet_transaction wt on wt.txn_code = dt.txn_code and dt.consumer_id=wt.consumer_id
JOIN udio_wallet.dw_user_wallet uw on uw.id = wt.user_wallet_id
WHERE u.product_id=2 AND dt.merchant_id in (40006939,40006976) AND dt.txn_mode='cr'
AND dt.transaction_status='success'
AND (dt.txn_refnum like ('%PL%') or dt.txn_refnum like ('%TP%'))
AND uw.wallet_type_id = 12
AND dt.transaction_date < CURDATE();


#MERCHANT ID  - 40006964
select b.mobile_number,a.amount,a.updated_date from udio_wallet.dw_transaction a
INNER JOIN udio_wallet.b2c_user b
ON a.consumer_id = b.consumer_id
where a.merchant_id='40006964'
and b.product_id=2
and a.txn_mode='cr'
and a.transaction_status='success';

select * FROM udio_wallet.dw_payout_request where merchant_id='40006964';


SELECT
count(b.mobile_number), sum(a.amount) from udio_wallet.dw_transaction a
JOIN udio_wallet.dw_wallet_transaction wt on wt.txn_code = a.txn_code and a.consumer_id=wt.consumer_id
JOIN udio_wallet.dw_user_wallet uw on uw.id = wt.user_wallet_id
INNER JOIN udio_wallet.b2c_user b
ON a.consumer_id = b.consumer_id
WHERE a.mobile_number in ("","") 
and a.transaction_status='success'
and a.txn_type_code = 'mcd'
and a.txn_mode = 'cr'
and uw.wallet_type_id = 12
and a.merchant_id in (40006939, 40006976)
AND (a.txn_refnum like ('%PL%') OR a.txn_refnum like ('%TP%'))
and (a.transaction_date >= '2019-07-23 00:00:00' AND a.transaction_date < CURDATE());

SELECT * FROM udio_wallet.dl_payment_collection order by id desc;

SELECT * FROM udio_wallet.dw_wallet_transaction order by id desc;

SELECT * FROM udio_wallet.dw_wallet_closing_balance where product_id='2' order by id desc;

SELECT * FROM udio_wallet.dw_wallet_closing_balance where product_id='2' and consumer_id='8456847861213835445';
SELECT * FROM udio_wallet.dw_user_wallet where consumer_id='8456847861213835445';

#### Wallet to Wallet transfer
select * from udio_wallet.dw_w2w_transaction order by id desc;

############# Recharge TO OTHER number
select a.mobile_number, a.recharge_type, a.operator_type, a.operator, a.amount, a.transaction_status, a.consumer_id, b.mobile_number, a.recharge_for
from udio_wallet.dw_recharge_transaction a
inner join udio_wallet.b2c_user b
on a.consumer_id = b.consumer_id
where operator_type = 'MOBILE'
AND transaction_status='success'
AND a.mobile_number <> b.mobile_number;


#UDIO TREATS
select b.mobile_number,a.amount,a.updated_date, wt.wallet_type_id from udio_wallet.dw_transaction a
inner join udio_wallet.dw_wallet_transaction wt
on a.consumer_id = wt.consumer_id and a.txn_code = wt.txn_code
INNER JOIN udio_wallet.b2c_user b
ON a.consumer_id = b.consumer_id
where a.merchant_id='40006964'
and b.product_id=2
and a.txn_mode='cr';


select DISTINCT status from udio_wallet.dw_user_merchant where product_id=2;

SELECT DISTINCT a.status as count FROM udio_wallet.dw_user_merchant a
        JOIN udio_wallet.b2c_user b ON a.consumer_id=b.consumer_id
        WHERE a.merchant_id = 1111 AND b.mobile_number IN (SELECT
        b.mobile_number from udio_wallet.dw_transaction a
        JOIN udio_wallet.b2c_user b ON a.consumer_id=b.consumer_id
        JOIN udio_wallet.dw_wallet_transaction wt on wt.txn_code = a.txn_code and a.consumer_id=wt.consumer_id and a.transaction_status=wt.status
        JOIN udio_wallet.dw_user_wallet uw on uw.id = wt.user_wallet_id
        and a.transaction_status='success'
        AND a.merchant_id in (40006939,40006976)
        and a.txn_mode = 'cr'
        and uw.wallet_type_id = 12);

SELECT
        count(b.mobile_number) AS count from udio_wallet.dw_transaction a
        JOIN udio_wallet.b2c_user b ON a.consumer_id=b.consumer_id
        JOIN udio_wallet.dw_wallet_transaction wt on wt.txn_code = a.txn_code and a.consumer_id=wt.consumer_id and a.transaction_status=wt.status
        JOIN udio_wallet.dw_user_wallet uw on uw.id = wt.user_wallet_id
        WHERE a.mobile_number in ("","") 
        and a.transaction_status='success'
        AND a.merchant_id in (40006939,40006976)
        and a.txn_mode = 'cr'
        and uw.wallet_type_id = 12
        AND a.created_date <= DATE_SUB(CURRENT_DATE,INTERVAL 15 DAY)
        AND b.mobile_number NOT IN (SELECT b.mobile_number FROM udio_wallet.dw_user_merchant a
        JOIN udio_wallet.b2c_user b ON a.consumer_id=b.consumer_id
        WHERE a.merchant_id = 1111);
       
 
       
SELECT
count(b.mobile_number), sum(a.amount) from udio_wallet.dw_transaction a
JOIN udio_wallet.dw_wallet_transaction wt on wt.txn_code = a.txn_code and a.consumer_id=wt.consumer_id
JOIN udio_wallet.dw_user_wallet uw on uw.id = wt.user_wallet_id
INNER JOIN udio_wallet.b2c_user b
ON a.consumer_id = b.consumer_id
WHERE a.mobile_number in ("","") 
and a.transaction_status='success'
and a.txn_type_code = 'mcd'
and a.txn_mode = 'cr'
and uw.wallet_type_id = 12
and a.merchant_id in (40006939, 40006976)
AND (a.txn_refnum like ('%PL%') OR a.txn_refnum like ('%TP%'))
and (a.transaction_date >= '2019-07-16 00:00:00' AND a.transaction_date <= '2019-07-23 23:59:59');     

       
SELECT
count(b.mobile_number), sum(a.amount) from udio_wallet.dw_transaction a
JOIN udio_wallet.dw_wallet_transaction wt on wt.txn_code = a.txn_code and a.consumer_id=wt.consumer_id
JOIN udio_wallet.dw_user_wallet uw on uw.id = wt.user_wallet_id
INNER JOIN udio_wallet.b2c_user b
ON a.consumer_id = b.consumer_id
WHERE a.mobile_number in ("","") 
and a.transaction_status='success'
and a.txn_type_code = 'mcd'
and a.txn_mode = 'cr'
and uw.wallet_type_id = 12
and a.merchant_id in (40006939, 40006976)
AND (a.txn_refnum like ('%PL%') OR a.txn_refnum like ('%TP%'))
and DATE(a.transaction_date) BETWEEN CURDATE()-8 AND CURDATE()-1;


SELECT date(CURDATE()-1);

select DATE_SUB(CURRENT_DATE,INTERVAL 3 DAY)


select DISTINCT status from udio_wallet.b2c_user where product_id=2;


select count(DISTINCT a.mobile_number) from udio_wallet.b2c_user a
inner join udio_wallet.dw_ppi_bank_user b
on a.mobile_number = b.mobile_number
where a.product_id=2 and a.status='active';

select * from udio_wallet.b2c_user where mobile_number='';


select a.mobile_number, a.kyc_level, b.status, b.product_id from udio_wallet.dw_ppi_bank_user a
inner join udio_wallet.b2c_user b 
on a.mobile_number = b.mobile_number and a.status = b.status
where b.product_id = 2
and a.status = 'active';


select * from udio_wallet.dw_card_dispatch_detail order by id desc;

select * from udio_wallet.dw_card_repo where card_type = 'plastic' order by id desc;

select * from udio_wallet.dw_communication;


select * from udio_wallet.dw_user_merchant;


select count(*) from udio_wallet.dw_user_merchant where merchant_id='1111' and status='active';


############# ALL Recharges
select a.mobile_number AS 'Recharge Number', a.recharge_type, a.operator_type, a.operator, a.amount, a.transaction_status, a.consumer_id, b.mobile_number, a.recharge_for
from udio_wallet.dw_recharge_transaction a
inner join udio_wallet.b2c_user b
on a.consumer_id = b.consumer_id
where a.operator_type = 'MOBILE'
AND a.transaction_status='success'
and b.product_id=2
and b.status='active'
and a.transaction_date >= '2019-07-23' and a.transaction_date < CURDATE();


############# Recharge TO OTHER number
select a.mobile_number AS 'Recharge Number', a.recharge_type, a.operator_type, a.operator, a.amount, a.transaction_status, a.consumer_id, b.mobile_number, a.recharge_for
from udio_wallet.dw_recharge_transaction a
inner join udio_wallet.b2c_user b
on a.consumer_id = b.consumer_id
where operator_type = 'MOBILE'
AND a.transaction_status='success'
and b.product_id=2
and b.status='active'
AND a.mobile_number <> b.mobile_number
and a.transaction_date >= '2019-07-22' and a.transaction_date < CURDATE();


############# Recharge TO SAME number
select a.mobile_number AS 'Recharge Number', a.recharge_type, a.operator_type, a.operator, a.amount, a.transaction_status, a.consumer_id, b.mobile_number, a.recharge_for
from udio_wallet.dw_recharge_transaction a
inner join udio_wallet.b2c_user b
on a.consumer_id = b.consumer_id
where operator_type = 'MOBILE'
AND transaction_status='success'
and b.product_id=2
and b.status='active'
AND a.mobile_number = b.mobile_number
and a.transaction_date < CURDATE();



select * from udio_wallet.dw_user_card a
inner join udio_wallet.dw_card_repo b
on a.card_uid = b.card_uid
where a.status='active' and a.merchant_id=1111 and a.card_enabled=1;

select * from udio_wallet.dw_communication order by id desc;
