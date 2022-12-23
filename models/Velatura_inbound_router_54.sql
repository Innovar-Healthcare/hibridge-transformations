with d_m54 as (
	select
		id,
		processed
	from mirth_dw.public.d_m54

),

d_mcm54 as (
	select 
	      "ACTION",
	      message_id
	       from mirth_dw.public.d_mcm54
),

d_mm54 as (
	select
		message_id,
		received_date,
		response_date,
		connector_name,
		error_code
	from mirth_dw.public.d_mm54
),

final as (

	select  
	d_m54.id,
	d_m54.processed,
	d_mm54.received_date,
	d_mcm54."ACTION", 
	d_mm54.response_date,
	d_mm54.connector_name, 
	d_mm54.error_code
    from d_m54
    left join d_mm54
	on d_m54.id=d_mm54.message_id
    left join d_mcm54
	on d_m54.id=d_mcm54.message_id
)

select  distinct * from final order by id
