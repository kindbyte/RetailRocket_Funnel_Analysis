with first_transaction as (
select visitorid, min(event_time::date) as first_purchase_date
from retailrocket.events
where event='transaction'
group by visitorid
),
activity_date as (
select f.first_purchase_date as cohort, f.visitorid, e.event_time::date as activity_date
from first_transaction f
join retailrocket.events e on
f.visitorid=e.visitorid 
where event='transaction'
)
select cohort, activity_date, count(distinct visitorid) as active_users, 
round(100 * count(distinct visitorid)::numeric/
nullif(
(select count(*)
from first_transaction
where first_purchase_date=activity_date.cohort),0)
,2) as returned_percent
from activity_date
group by cohort, activity_date
order by cohort, activity_date
;


