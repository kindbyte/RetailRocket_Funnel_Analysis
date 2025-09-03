with number_transaction as (
select visitorid,  count(*) as tns_cnt
from retailrocket.events
where event = 'transaction'
group by visitorid
)
select count(*) as total_buyers, count(*) filter (where tns_cnt >= 2) as repeat_buyers,
round(100 * 
count(*) filter (where tns_cnt >= 2)::numeric /
nullif(count(*),0), 2) as repeat_rate
from number_transaction
;




