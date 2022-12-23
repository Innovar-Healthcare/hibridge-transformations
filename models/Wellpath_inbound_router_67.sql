with d_m67 as (
	select
		id,
		processed
	from mirth_dw.public.d_m67

),

d_mcm67 as (
	select 
	      "ACTION",
	      message_id
	       from mirth_dw.public.d_mcm67
),

d_mm67 as (
	select
		message_id,
		received_date,
		response_date,
		connector_name,
		error_code
	from mirth_dw.public.d_mm67
),

final as (

	select  
	d_m67.id,
	d_m67.processed,
	d_mm67.received_date,
	d_mcm67."ACTION", 
	d_mm67.response_date,
	d_mm67.connector_name, 
	d_mm67.error_code
    from d_m67
    left join d_mm67
	on d_m67.id=d_mm67.message_id
    left join d_mcm67
	on d_m67.id=d_mcm67.message_id
)

select  distinct * from final order by id
