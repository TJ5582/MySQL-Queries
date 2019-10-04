# O) Customers registered through merchant
SELECT COUNT(*) FROM udio_wallet.dw_user_merchant WHERE merchant_id = 40006939 and created_date > '2019-07-01'

# C) Among Customers registered through merchant, how many registered though app
SELECT COUNT(*) FROM udio_wallet.dw_user_merchant a
JOIN udio_wallet.b2c_user b ON a.consumer_id=b.consumer_id 
WHERE a.merchant_id = 1111 AND a.created_date > ''
AND b.mobile_number IN (SELECT b.mobile_number FROM udio_wallet.dw_user_merchant a
JOIN udio_wallet.b2c_user b ON a.consumer_id=b.consumer_id 
WHERE a.merchant_id = 40006939)

# D) Customers who registered through merchant but not registered through app in 15 days
SELECT COUNT(*) FROM udio_wallet.dw_user_merchant a
JOIN udio_wallet.b2c_user b ON a.consumer_id=b.consumer_id 
WHERE a.merchant_id = 40006939
AND a.created_date <= DATE_SUB(NOW(),INTERVAL 15 DAY)
AND b.mobile_number NOT IN (SELECT b.mobile_number FROM udio_wallet.dw_user_merchant a
JOIN udio_wallet.b2c_user b ON a.consumer_id=b.consumer_id 
WHERE a.merchant_id = 1111)


# A) Number of customers got loan in account
SELECT
count(a.consumer_id) from udio_wallet.dw_transaction a
JOIN udio_wallet.dw_wallet_transaction wt on wt.txn_code = a.txn_code and a.consumer_id=wt.consumer_id
JOIN udio_wallet.dw_user_wallet uw on uw.id = wt.user_wallet_id
and a.transaction_status='success'
AND a.merchant_id=40006939
and a.txn_type_code = 'mcd'
and a.txn_mode = 'cr'
and uw.wallet_type_id = 12
AND a.created_date = ''

# B) Amount of loan got loaded
SELECT
sum(a.amount) from udio_wallet.dw_transaction a
JOIN udio_wallet.dw_wallet_transaction wt on wt.txn_code = a.txn_code and a.consumer_id=wt.consumer_id
JOIN udio_wallet.dw_user_wallet uw on uw.id = wt.user_wallet_id
and a.transaction_status='success'
AND a.merchant_id=40006939
and a.txn_type_code = 'mcd'
and a.txn_mode = 'cr'
and uw.wallet_type_id = 12
AND a.created_date = ''

# E) Customers who havent used loan amount at all
SELECT COUNT(*) FROM udio_wallet.dw_user_wallet a
JOIN (SELECT
a.consumer_id,sum(a.amount) AS credited_amount from udio_wallet.dw_transaction a
JOIN udio_wallet.dw_wallet_transaction wt on wt.txn_code = a.txn_code and a.consumer_id=wt.consumer_id
JOIN udio_wallet.dw_user_wallet uw on uw.id = wt.user_wallet_id
and a.transaction_status='success'
AND a.merchant_id=40006939
and a.txn_type_code = 'mcd'
and a.txn_mode = 'cr'
and uw.wallet_type_id = 12
group BY 1) b ON a.consumer_id = b.consumer_id
WHERE a.wallet_type_id=12
and a.balance/b.credited_amount = 1

# G) 	Customers who have fully used loan amount
SELECT COUNT(*) FROM udio_wallet.dw_user_wallet a
JOIN (SELECT
a.consumer_id,sum(a.amount) AS credited_amount from udio_wallet.dw_transaction a
JOIN udio_wallet.dw_wallet_transaction wt on wt.txn_code = a.txn_code and a.consumer_id=wt.consumer_id
JOIN udio_wallet.dw_user_wallet uw on uw.id = wt.user_wallet_id
and a.transaction_status='success'
AND a.merchant_id=40006939
and a.txn_type_code = 'mcd'
and a.txn_mode = 'cr'
and uw.wallet_type_id = 12
group BY 1) b ON a.consumer_id = b.consumer_id
WHERE a.wallet_type_id=12
and a.balance/b.credited_amount = 0

# F) Customers who have partially used loan amount
SELECT COUNT(*) FROM udio_wallet.dw_user_wallet a
JOIN (SELECT
a.consumer_id,sum(a.amount) AS credited_amount from udio_wallet.dw_transaction a
JOIN udio_wallet.dw_wallet_transaction wt on wt.txn_code = a.txn_code and a.consumer_id=wt.consumer_id
JOIN udio_wallet.dw_user_wallet uw on uw.id = wt.user_wallet_id
and a.transaction_status='success'
AND a.merchant_id=40006939
and a.txn_type_code = 'mcd'
and a.txn_mode = 'cr'
and uw.wallet_type_id = 12
group BY 1) b ON a.consumer_id = b.consumer_id
WHERE a.wallet_type_id=12
and a.balance/b.credited_amount > 0 and a.balance/b.credited_amount < 1

# H) Total unused balance from the customers who havent registered through app yet
SELECT SUM(balance) FROM udio_wallet.dw_user_wallet
WHERE wallet_type_id = 12
AND consumer_id IN (SELECT a.consumer_id FROM udio_wallet.dw_user_merchant a
JOIN udio_wallet.b2c_user b ON a.consumer_id=b.consumer_id 
WHERE a.merchant_id = 40006939
AND b.mobile_number NOT IN (SELECT b.mobile_number FROM udio_wallet.dw_user_merchant a
JOIN udio_wallet.b2c_user b ON a.consumer_id=b.consumer_id 
WHERE a.merchant_id = 1111))


# I) Total unique customers used recharge/billpay using loan money
SELECT COUNT(DISTINCT a.consumer_id) FROM udio_wallet.dw_transaction a
FULL JOIN udio_wallet.dw_wallet_transaction b on b.txn_code = a.txn_code
WHERE a.transaction_status='success' 
and b.wallet_type_id = 12
AND a.txn_type_code IN ('REC','BIL')
AND a.created_date = ''

# M) Total unique customers did card transaction using loan money
SELECT COUNT(DISTINCT a.consumer_id) FROM udio_wallet.dw_transaction a
JOIN udio_wallet.dw_wallet_transaction b on b.txn_code = a.txn_code
WHERE a.transaction_status='success' 
and b.wallet_type_id = 12
AND a.txn_type_code IN ('CT')
AND a.created_date = ''

# K) Total unique customers bought vouchers using loan money
SELECT COUNT(DISTINCT a.consumer_id) FROM udio_wallet.dw_transaction a
JOIN udio_wallet.dw_wallet_transaction b on b.txn_code = a.txn_code
WHERE a.transaction_status='success' 
and b.wallet_type_id = 12
AND a.txn_type_code IN ('OG')
AND a.created_date = ''

# J) Total amount for customers used recharge/billpay using loan money
SELECT SUM(a.amount) FROM udio_wallet.dw_transaction a
FULL JOIN udio_wallet.dw_wallet_transaction b on b.txn_code = a.txn_code
WHERE a.transaction_status='success' 
and b.wallet_type_id = 12
AND a.txn_type_code IN ('REC','BIL')
AND a.created_date = ''

# N) Total amount for customers who did card transaction using loan money
SELECT SUM(a.amount) FROM udio_wallet.dw_transaction a
JOIN udio_wallet.dw_wallet_transaction b on b.txn_code = a.txn_code
WHERE a.transaction_status='success' 
and b.wallet_type_id = 12
AND a.txn_type_code IN ('CT')
AND a.created_date = ''

# L) Total amount for customers who bought vouchers using loan money
SELECT SUM(a.amount) FROM udio_wallet.dw_transaction a
JOIN udio_wallet.dw_wallet_transaction b on b.txn_code = a.txn_code
WHERE a.transaction_status='success' 
and b.wallet_type_id = 12
AND a.txn_type_code IN ('OG')
AND a.created_date = ''