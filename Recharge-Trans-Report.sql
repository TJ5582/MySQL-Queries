
SELECT * from udio_wallet.dw_recharge_transaction a
INNER JOIN udio_wallet.b2c_user b
ON a.consumer_id = b.consumer_id
where a.transaction_status='success'
and a.operator_type='MOBILE'
AND a.transaction_date >= '2019-07-01 00:00:00' and a.transaction_date <= '2019-07-31 23:59:59'
and b.status = 'active'
and b.product_id=2;

SELECT sum(a.amount), count(DISTINCT a.consumer_id), count(a.txn_code) from udio_wallet.dw_recharge_transaction a
INNER JOIN udio_wallet.b2c_user b
ON a.consumer_id = b.consumer_id
where a.transaction_status='success'
and a.operator_type='MOBILE'
AND a.transaction_date >= '2019-07-01 00:00:00' and a.transaction_date <= '2019-07-31 23:59:59'
and b.product_id=2
and b.status = 'active';

#### PREPAID & POSTPAID DETAILS
SELECT a.recharge_type, sum(a.amount), count(DISTINCT a.consumer_id), count(a.txn_code), round(sum(a.amount)/count(DISTINCT a.consumer_id),0), round(avg(a.amount),0) from udio_wallet.dw_recharge_transaction a
INNER JOIN udio_wallet.b2c_user b
ON a.consumer_id = b.consumer_id
where a.transaction_status='success'
and a.operator_type='MOBILE'
AND a.transaction_date >= '2019-07-01 00:00:00' and a.transaction_date <= '2019-07-31 23:59:59'
and b.product_id=2
and b.status='active'
GROUP by 1;

#### DAILY RECHARGE DETAILS
SELECT DATE_FORMAT(a.transaction_date,'%d-%M') AS 'Transaction Date', sum(a.amount), count(DISTINCT a.consumer_id), count(a.txn_code) from udio_wallet.dw_recharge_transaction a
INNER JOIN udio_wallet.b2c_user b
ON a.consumer_id = b.consumer_id
where a.transaction_status='success'
and a.operator_type='MOBILE'
AND a.transaction_date >= '2019-07-01 00:00:00' and a.transaction_date <= '2019-07-31 23:59:59'
and b.product_id=2
and b.status = 'active'
group by 1;


#### Opertor Amount DETAILS
SELECT a.operator, sum(a.amount), count(DISTINCT a.consumer_id), count(a.txn_code), round(sum(a.amount)/count(DISTINCT a.consumer_id),0), round(avg(a.amount),0) from udio_wallet.dw_recharge_transaction a
INNER JOIN udio_wallet.b2c_user b
ON a.consumer_id = b.consumer_id
where a.transaction_status='success'
and a.operator_type='MOBILE'
AND a.transaction_date >= '2019-07-01 00:00:00' and a.transaction_date <= '2019-07-31 23:59:59'
and b.product_id=2
and b.status = 'active'
GROUP BY 1;

#### PREPAID & POSTPAID by Opertor DETAILS
SELECT a.recharge_type, a.operator, sum(a.amount), count(DISTINCT a.consumer_id), count(a.txn_code), round(sum(a.amount)/count(DISTINCT a.mobile_number),0), round(avg(a.amount),0) from udio_wallet.dw_recharge_transaction a
INNER JOIN udio_wallet.b2c_user b
ON a.consumer_id = b.consumer_id
where a.transaction_status='success'
and a.operator_type='MOBILE'
AND a.transaction_date >= '2019-07-01 00:00:00' and a.transaction_date <= '2019-07-31 23:59:59'
and b.product_id=2
and b.status = 'active'
GROUP BY 1,2;


#### NO. OF RECHARGE DONE BY USERS
SELECT
DISTINCT a.consumer_id AS "No. of Users",
count(a.txn_code) as "No. of Transactions",
sum(a.amount) as "Total Amount"
from udio_wallet.dw_recharge_transaction a
INNER JOIN udio_wallet.b2c_user c
ON a.consumer_id = c.consumer_id
where a.transaction_status='success'
and c.product_id=2
and c.status = 'active'
and a.operator_type ='MOBILE'
AND a.transaction_date >= '2019-07-01 00:00:00' and a.transaction_date <= '2019-07-31 23:59:59'
group by 1;


############ Pivot Table = NO. OF MOBILE RECHARGES PER USER
select x.Transactions, count(distinct x.Users) from (
SELECT
DISTINCT a.consumer_id AS "Users",
count(a.txn_code) as "Transactions",
sum(a.amount) as "Total Amount"
from udio_wallet.dw_recharge_transaction a
INNER JOIN udio_wallet.b2c_user c
ON a.consumer_id = c.consumer_id
where a.transaction_status='success'
and c.product_id=2
and c.status = 'active'
and a.operator_type ='MOBILE'
AND a.transaction_date >= '2019-07-01 00:00:00' and a.transaction_date <= '2019-07-31 23:59:59'
group by 1
) x group by 1;


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
AND a.transaction_date >= '2019-07-01 00:00:00' and a.transaction_date <= '2019-07-31 23:59:59';


select a.operator_type, sum(a.amount), count(DISTINCT a.consumer_id), count(a.txn_code) 
from udio_wallet.dw_recharge_transaction a
inner join udio_wallet.b2c_user b
on a.consumer_id = b.consumer_id
where operator_type = 'MOBILE'
AND transaction_status='success'
and b.product_id=2
and b.status='active'
AND a.mobile_number = b.mobile_number
AND a.transaction_date >= '2019-07-01 00:00:00' and a.transaction_date <= '2019-07-31 23:59:59'
group by 1;

select a.recharge_type, sum(a.amount), count(DISTINCT a.consumer_id), count(a.txn_code)
from udio_wallet.dw_recharge_transaction a
inner join udio_wallet.b2c_user b
on a.consumer_id = b.consumer_id
where operator_type = 'MOBILE'
AND transaction_status='success'
and b.product_id=2
and b.status='active'
AND a.mobile_number = b.mobile_number
AND a.transaction_date >= '2019-07-01 00:00:00' and a.transaction_date <= '2019-07-31 23:59:59'
group by 1;

############# Recharge TO OTHER number
select a.mobile_number AS 'Recharge Number', a.recharge_type, a.operator_type, a.operator, a.amount, a.transaction_status, a.consumer_id, b.mobile_number, a.recharge_for
from udio_wallet.dw_recharge_transaction a
inner join udio_wallet.b2c_user b
on a.consumer_id = b.consumer_id
where operator_type = 'MOBILE'
AND a.transaction_status='success'
and b.product_id=2
and b.status='active'
AND a.mobile_number != b.mobile_number
AND a.transaction_date >= '2019-07-01 00:00:00' and a.transaction_date <= '2019-07-31 23:59:59';


select a.operator_type, sum(a.amount), count(DISTINCT a.consumer_id), count(a.txn_code) 
from udio_wallet.dw_recharge_transaction a
inner join udio_wallet.b2c_user b
on a.consumer_id = b.consumer_id
where operator_type = 'MOBILE'
AND transaction_status='success'
and b.product_id=2
and b.status='active'
AND a.mobile_number != b.mobile_number
AND a.transaction_date >= '2019-07-01 00:00:00' and a.transaction_date <= '2019-07-31 23:59:59'
group by 1;

select a.recharge_type, sum(a.amount), count(DISTINCT a.consumer_id), count(a.txn_code)
from udio_wallet.dw_recharge_transaction a
inner join udio_wallet.b2c_user b
on a.consumer_id = b.consumer_id
where operator_type = 'MOBILE'
AND transaction_status='success'
and b.product_id=2
and b.status='active'
AND a.mobile_number != b.mobile_number
AND a.transaction_date >= '2019-07-01 00:00:00' and a.transaction_date <= '2019-07-31 23:59:59'
group by 1;


### Top Operator circle for recharge
select a.operator_circle, SUM(a.amount), COUNT(DISTINCT a.consumer_id), count(txn_code)
from udio_wallet.dw_recharge_transaction a
inner join udio_wallet.b2c_user b
on a.consumer_id = b.consumer_id
where operator_type = 'MOBILE'
AND a.transaction_status='success'
and b.product_id=2
and b.status='active'
AND a.transaction_date >= '2019-07-01 00:00:00' and a.transaction_date <= '2019-07-31 23:59:59'
group by 1
order by 2 desc;



### Operator Circle - Recharge Type
select a.operator_circle as 'Operator Circle', a.recharge_type as 'Recharge Type', SUM(a.amount) as 'Amount', COUNT(DISTINCT a.consumer_id), COUNT(a.txn_code)
from udio_wallet.dw_recharge_transaction a
inner join udio_wallet.b2c_user b
on a.consumer_id = b.consumer_id
where operator_type = 'MOBILE'
AND a.transaction_status='success'
and b.product_id=2
and b.status='active'
AND a.transaction_date >= '2019-07-01 00:00:00' and a.transaction_date <= '2019-07-31 23:59:59'
group by 1,2;

### Operator Circle - Operator Data
select a.operator_circle as 'Operator Circle', a.operator as 'Operator', sum(a.amount) as 'Amount', count(DISTINCT a.consumer_id), COUNT(a.txn_code)
from udio_wallet.dw_recharge_transaction a
inner join udio_wallet.b2c_user b
on a.consumer_id = b.consumer_id
where operator_type = 'MOBILE'
AND a.transaction_status='success'
and b.product_id=2
and b.status='active'
AND a.transaction_date >= '2019-07-01 00:00:00' and a.transaction_date <= '2019-07-31 23:59:59'
group by 1,2;


### Operator Circle - Operator Data - Recharge type
select a.operator_circle as 'Operator Circle', a.operator as 'Operator', a.recharge_type as 'Recharge Type', sum(a.amount) as 'Amount', count(DISTINCT a.consumer_id), COUNT(a.txn_code)
from udio_wallet.dw_recharge_transaction a
inner join udio_wallet.b2c_user b
on a.consumer_id = b.consumer_id
where operator_type = 'MOBILE'
AND a.transaction_status='success'
and b.product_id=2
and b.status='active'
AND a.transaction_date >= '2019-07-01 00:00:00' and a.transaction_date <= '2019-07-31 23:59:59'
group by 1,2,3;


### Wallet wise Recharge data

SELECT wt.wallet_type_id,
sum(wt.amount) as "Amount",
count(DISTINCT a.consumer_id) as "Users",
round(sum(wt.amount)/count(DISTINCT a.consumer_id),0) as "Avg. Tkt User",
count(wt.txn_code) as "No. of Transactions",
round(avg(wt.amount),0) as "Avg. Tkt Transactions"
from udio_wallet.dw_wallet_transaction wt
INNER JOIN udio_wallet.dw_transaction b
ON wt.consumer_id=b.consumer_id and wt.txn_code = b.txn_code
JOIN udio_wallet.dw_recharge_transaction a
on wt.txn_code = a.txn_code and a.consumer_id=wt.consumer_id
INNER JOIN udio_wallet.b2c_user c
ON a.consumer_id = c.consumer_id
where a.operator_type='MOBILE'
and a.transaction_status='success'
and a.transaction_date >= '2019-07-01 00:00:00' and a.transaction_date <= '2019-07-31 23:59:59'
and b.transaction_status='success'
and b.product_id=2
and c.status='active'
group by 1;



### Wallet wise Recharge Type data
SELECT wt.wallet_type_id,
a.recharge_type,
sum(wt.amount) as "Amount",
count(DISTINCT a.consumer_id) as "Users",
round(sum(wt.amount)/count(DISTINCT a.consumer_id),0) as "Avg. Tkt User",
count(wt.txn_code) as "No. of Transactions",
round(avg(wt.amount),0) as "Avg. Tkt Transactions"
from udio_wallet.dw_wallet_transaction wt
INNER JOIN udio_wallet.dw_transaction b
ON wt.consumer_id=b.consumer_id and wt.txn_code = b.txn_code
JOIN udio_wallet.dw_recharge_transaction a
on wt.txn_code = a.txn_code and a.consumer_id=wt.consumer_id
INNER JOIN udio_wallet.b2c_user c
ON a.consumer_id = c.consumer_id
where a.operator_type='MOBILE'
and a.transaction_status='success'
and a.transaction_date >= '2019-07-01 00:00:00' and a.transaction_date <= '2019-07-31 23:59:59'
and b.transaction_status='success'
and b.product_id=2
and c.status='active'
group by 1,2;


### Wallet wise Operator data
SELECT wt.wallet_type_id,
a.operator,
sum(wt.amount) as "Amount",
count(DISTINCT a.consumer_id) as "Users",
round(sum(wt.amount)/count(DISTINCT a.consumer_id),0) as "Avg. Tkt User",
count(wt.txn_code) as "No. of Transactions",
round(avg(wt.amount),0) as "Avg. Tkt Transactions"
from udio_wallet.dw_wallet_transaction wt
INNER JOIN udio_wallet.dw_transaction b
ON wt.consumer_id=b.consumer_id and wt.txn_code = b.txn_code
JOIN udio_wallet.dw_recharge_transaction a
on wt.txn_code = a.txn_code and a.consumer_id=wt.consumer_id
INNER JOIN udio_wallet.b2c_user c
ON a.consumer_id = c.consumer_id
where a.operator_type='MOBILE'
and a.transaction_status='success'
and a.transaction_date >= '2019-07-01 00:00:00' and a.transaction_date <= '2019-07-31 23:59:59'
and b.transaction_status='success'
and b.product_id=2
and c.status='active'
group by 1,2;



