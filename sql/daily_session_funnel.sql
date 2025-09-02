select date(session_start) as session_date,
count(*) filter (where has_view) as view_cnt,
count(*) filter (where has_add_tocart) as add_tocart_cnt,
count(*) filter (where has_transaction) as transaction_cnt,
round(
count(*) filter (where has_add_tocart)::numeric/
nullif(count(*) filter (where has_view),0)
* 100, 2
) as view_to_cart_pct,
round(
count(*) filter (where has_transaction)::numeric/
nullif(count(*) filter (where has_add_tocart),0)
* 100, 2
) as cart_to_trans_pct,
round (
count(*) filter (where has_transaction)::numeric/
nullif(count(*) filter (where has_view),0)
* 100, 2
) as view_to_trans_pct
from session_summary
group by date(session_start)
order by date(session_start)
;

