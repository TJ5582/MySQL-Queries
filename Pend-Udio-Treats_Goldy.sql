#MERCHANT ID  - 40006964
select b.mobile_number,a.amount,a.updated_date from udio_wallet.dw_transaction a
INNER JOIN udio_wallet.b2c_user b
ON a.consumer_id = b.consumer_id
where a.merchant_id='40006964'
and b.product_id=2
and a.txn_mode='cr'
and a.transaction_status='success';

#PENDING UDIO TREATS
select * FROM udio_wallet.dw_payout_request where merchant_id='40006964';

select * from udio_wallet.dw_transaction a
inner join udio_wallet.b2c_user b
on a.consumer_id = b.consumer_id and a.product_id=2
where b.mobile_number in ("")
and a.product_id = 2
and a.transaction_status = 'success';
