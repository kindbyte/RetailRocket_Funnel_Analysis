with prev_ses as (
select visitorid, event_time, lag(event_time) over (partition by visitorid order by event_time) as prev_session
from retailrocket.events
),
diff as (
select visitorid, event_time, 
extract(epoch from (event_time - prev_session))/60 as minutes_between
from prev_ses
),
sep_session as (
select visitorid, event_time, case when minutes_between is null then 1
when minutes_between > 30 then 1
else  0
end as session
from diff
),
sess_number as (
select s.visitorid, s.event_time, r.event, sum(s.session) over (partition by s.visitorid order by s.event_time) as session_number
from sep_session s
join retailrocket.events r on s.visitorid = r.visitorid and s.event_time = r.event_time
),
existing as (
select visitorid, event_time::date, session_number, max (case when event  = 'view' then 1
else 0
end) as had_view, 
max (case when event  = 'addtocart' then 1
else 0
end) as had_cart,
max (case when event  = 'transaction' then 1
else 0
end) as had_transaction
from sess_number
group by visitorid, event_time::date, session_number
)
select event_time::date, count(*) filter (where had_view = 1) as view_sessions,
count(*) filter (where had_cart = 1) as cart_sessions,
count(*) filter (where had_transaction = 1) as transaction_session,
round(100.0 * count(*) filter (where had_cart = 1) / nullif(count(*) filter (where had_view = 1),0), 2) as view_to_cart,
round(100.0 * count(*) filter (where had_transaction = 1) / nullif(count(*) filter (where had_cart = 1),0), 2) as cart_to_purchase,
round(100.0 * count(*) filter (where had_transaction = 1) / nullif(count(*) filter (where had_view = 1),0), 2) as view_to_purchase
from existing
group by event_time::date;
