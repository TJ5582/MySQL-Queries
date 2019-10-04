select * from udio_wallet.dw_user_device_detail order by id desc limit 25;

### July login data
select *, b.mobile_number from udio_wallet.dw_user_device_detail a
inner join udio_wallet.b2c_user b 
on a.consumer_id = b.consumer_id
where a.merchant_id=1111 and a.product_id=2 and a.updated_date >= '2019-07-01 00:00:00' and a.updated_date <= '2019-07-31 23:59:59';

#### Total Count
select count(*) from udio_wallet.dw_user_device_detail
where action='login'
and merchant_id=1111
and product_id=2
and updated_date >= '2019-07-01 00:00:00' and updated_date <= '2019-07-31 23:59:59';

#### Daily Account per uid count
select DATE_FORMAT(updated_date,'%d-%M') AS 'Transaction Date',
count(DISTINCT uid) AS 'Device Id',
count(action) as 'Login',
count(DISTINCT consumer_id) as 'No. of Accounts',

select * from udio_wallet.b2c_user where consumer_id='8456847861213370264';
round(count(DISTINCT consumer_id)/count(DISTINCT uid),2)
from udio_wallet.dw_user_device_detail
where action='login'
and merchant_id=1111
and product_id=2
and updated_date >= '2019-07-01 00:00:00' and updated_date <= '2019-07-31 23:59:59'
GROUP by 1;

#### Device ID per No. of Accounts
select DISTINCT uid as 'Device Id',
count(action) as 'Login',
COUNT(DISTINCT consumer_id) as 'No. of Accounts'
from udio_wallet.dw_user_device_detail
where action='login'
and merchant_id=1111
and product_id=2
and updated_date >= '2019-07-01 00:00:00' and updated_date <= '2019-07-31 23:59:59'
GROUP by 1
ORDER by 3 DESC;


select * from udio_wallet.dw_user_device_detail where uid='866750037861567' and action='login' and product_id=2;

select DATE_FORMAT(updated_date,'%d-%M') AS 'Transaction Date', count(DISTINCT uid) AS 'Device Id', count(action) as 'Login', count(DISTINCT consumer_id) as 'No. of Accounts', round(count(DISTINCT consumer_id)/count(DISTINCT uid),2) from udio_wallet.dw_user_device_detail where uid='864316046509266' and action='login' and merchant_id=1111 and product_id=2 and updated_date >= '2019-07-01 00:00:00' and updated_date <= '2019-07-31 23:59:59' GROUP by 1;
