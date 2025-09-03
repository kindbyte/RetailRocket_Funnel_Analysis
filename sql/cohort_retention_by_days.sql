with first_transaction as(
select visitorid, min(event_time) as first_purchase
from retailrocket.events
where event = 'transaction'
group by visitorid
),
active_date as(
select f.visitorid, f.first_purchase as cohort, r.event_time:: date as active_date
from first_transaction f
join retailrocket.events r on 
f.visitorid = r.visitorid
where event = 'transaction'
),
retention as (
select cohort, extract(day from active_date - cohort) as days_past, count(distinct visitorid) as buyers,
round
(100 * count(distinct visitorid)::numeric/
nullif ((select count(*)
from first_transaction
where ad.cohort = first_transaction.first_purchase), 0), 2
) as retention
from active_date ad
group by cohort, days_past
)
select cohort, 
max(retention) filter (where days_past= 0) as day_0, 
max(retention) filter (where days_past= 1) as day_1,
max(retention) filter (where days_past= 2) as day_2,
max(retention) filter (where days_past= 3) as day_3
from retention
group by cohort
order by cohort
;
