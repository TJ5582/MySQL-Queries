#### Device ID per No. of Accounts
select DISTINCT uid as 'Device Id',
count(action) as 'Register',
COUNT(DISTINCT consumer_id) as 'No. of Accounts',
COUNT(DISTINCT product_id) as 'No. of Distinct Products',
COUNT(DISTINCT product_id) as 'No. of Distinct Merchants'
from udio_wallet.dw_user_device_detail
where action='register'
and product_id=2
and updated_date >= '2019-07-01 00:00:00' and updated_date <= '2019-07-31 23:59:59'
GROUP by 1
ORDER by 3 DESC;

#### Device ID per No. of Accounts
select DISTINCT uid as 'Device Id',
count(action) as 'Register',
COUNT(DISTINCT consumer_id) as 'No. of Accounts',
COUNT(DISTINCT product_id) as 'No. of Distinct Merchants'
from udio_wallet.dw_user_device_detail
where action='register'
and updated_date >= '2019-07-01 00:00:00' and updated_date <= '2019-07-31 23:59:59'
GROUP by 1
ORDER by 3 DESC;


select *
from udio_wallet.dw_user_device_detail
where action='register'
and updated_date >= '2019-07-01 00:00:00' and updated_date <= '2019-07-31 23:59:59';



select distinct action from udio_wallet.dw_user_device_detail;

select * from udio_wallet.dw_user_device_detail where uid = '' and action='register';

select * from udio_wallet.dw_user_device_detail where uid = '' and action='register';


select * from udio_wallet.dw_user_device_detail where uid = '' and action='register';

	
select * from udio_wallet.dw_user_device_detail where uid in ('') and action='register';




select * from udio_wallet.b2c_user where consumer_id='';

###### May 2019
select count(*) FROM udio_marketing.rule_engine_action_archive
where action_id=2
and status='COMPLETED' 
and added_at BETWEEN '2019-05-01 00:00:00' and '2019-05-31 23:59:59';

select campaign_name as 'Campaign Name', count(id) as 'SMS count' FROM udio_marketing.rule_engine_action_archive
where action_id=2
and status='COMPLETED'
and added_at BETWEEN '2019-05-01 00:00:00'and '2019-05-31 23:59:59';


select * FROM udio_marketing.rule_engine_action where action_id=2 and status='COMPLETED' order by id limit 50;

select count(*) FROM udio_marketing.rule_engine_action
where action_id=2
and status='COMPLETED'
and added_at BETWEEN '2019-07-01 00:00:00'and '2019-07-31 23:59:59';

#### 1st June 2019 onwards
select DATE_FORMAT(added_at,'%M') AS 'Added Date', count(*) FROM udio_marketing.rule_engine_action
where action_id=2
and status='COMPLETED'
and added_at BETWEEN '2019-05-01 00:00:00'and '2019-07-31 23:59:59'
group by 1;

## CAMPAIGN WISE COUNTS
select campaign_name as 'Campaign Name', count(id) as 'SMS count' FROM udio_marketing.rule_engine_action
where action_id=2
and status='COMPLETED'
and added_at BETWEEN '2019-07-01 00:00:00'and '2019-07-31 23:59:59'
GROUP BY 1;


SELECT campaign_name, action_content, added_at, DATE_FORMAT(added_at,'%d-%M') AS 'Added Date' from udio_marketing.rule_engine_action
where action_id=2
and status='COMPLETED'
and added_at BETWEEN '2019-07-01 00:00:00' and '2019-07-31 23:59:59';

