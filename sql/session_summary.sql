create materialized view session_summary as
with session_summary as (
select visitorid, session_number, min(event_time) as session_start,
max(event_time) as session_end, 
extract(epoch from (max(event_time) - min(event_time)))/60 as session_lasts, count(*) as events_number,
sum(case when event = 'view' then 1 else 0 end) as view_sessions,
sum(case when event = 'addtocart' then 1 else 0 end) as cart_sessions,
sum(case when event = 'transaction' then 1 else 0 end) as transaction_sessions,
bool_or(event = 'view') as has_view,
bool_or(event = 'addtocart') as has_add_tocart,
bool_or(event = 'transaction') as has_transaction
from events_tables
group by visitorid, session_number
)
select *
from session_summary
order by visitorid
;