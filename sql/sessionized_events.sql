create materialized view if not exists events_tables as 
with prev_time as (
select visitorid, event, event_time, lag (event_time) over (partition by  visitorid order by event_time) as prev_event_time
from retailrocket.events
),
diff_time as (
select visitorid, event, event_time, extract(epoch from (event_time - prev_event_time))/60 as time_passed
from prev_time
),
sessions as (
select visitorid, event, event_time, time_passed, case 
when time_passed is null then 1
when time_passed > 30 then 1
else 0
end as flagged_sessions
from diff_time
),
sessions_number as (
select visitorid, event, event_time, time_passed, flagged_sessions,
sum(flagged_sessions) over (partition by visitorid order by event_time) as session_number
from sessions
)
select *
from sessions_number;