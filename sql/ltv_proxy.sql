with first_purchase as (
select visitorid, min(event_time::date) as first_purchase_date
from events_tables
where event='transaction'
group by visitorid
),
cohort_transaction as (
select f.first_purchase_date as cohort, e.visitorid, count(*) as total_transactions
from first_purchase f
join retailrocket.events e on f.visitorid=e.visitorid
where event='transaction'
group by f.first_purchase_date, e.visitorid
)
select cohort, count(visitorid) as users_in_cohort, round(avg(total_transactions), 2) as ltv_proxy
from cohort_transaction
group by cohort
order by cohort;
