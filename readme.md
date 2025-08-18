RetailRocket Funnel Analysis (SQL + Tableau)

This project analyzes e-commerce user behavior using RetailRocket event data.

The main goal was to:
Build session logic (sessionization with a 30-minute inactivity threshold)
Calculate funnel conversion rates (View → Cart → Purchase)
Visualize results in Tableau

🔧 Tools & Skills
SQL: window functions, CTEs, sessionization, funnel metrics
Tableau: funnel breakdown, time-series trends, interactive visualization
Analytics: conversion analysis, user journey insights, KPI tracking

📊 Key Findings
Only 2.5% of sessions progressed from View → Cart
31.8% of carts converted into purchases
Overall, just 0.8% of viewing sessions resulted in a transaction

🔎 Business Insights
- Low View→Cart conversion (2.5%) points to possible product attractiveness or UX issues → requires attention from marketing & product teams (product recommendations, CTA optimization, A/B testing).
- Strong Cart→Purchase conversion (31.8%) shows that once users add items, they are relatively committed. The bottleneck lies in motivating users to add to cart.
- Overall View→Purchase conversion (0.8%) indicates a significant opportunity for retargeting, personalization, and promotional campaigns.

📂 Project Structure
sql/funnel_analysis.sql – SQL code for sessionization & funnel calculation
tableau/funnel_dashboard.png – dashboard preview (funnel breakdown + session trends)

🔗 Tableau Public Dashboard (https://public.tableau.com/views/RetailRocketConversionFunnelDashboard/Dashboard1?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

🚀 Next Steps
Add segmentation (device type, referral channel, product category)
Perform A/B test simulation on conversion optimization strategies
Extend with cohort analysis for retention & repeat purchase patterns