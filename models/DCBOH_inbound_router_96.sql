with d_m96 as (
	select
		id,
		processed
	from mirth_dw.public.d_m96

),

d_mcm96 as (
	select 
	      "ACTION",
	      message_id
	       from mirth_dw.public.d_mcm96
),

d_mm96 as (
	select
		message_id,
		received_date,
		response_date,
		connector_name,
		error_code
	from mirth_dw.public.d_mm96
),

final as (

	select  
	d_m96.id,
	d_m96.processed,
	d_mm96.received_date,
	d_mcm96."ACTION", 
	d_mm96.response_date,
	d_mm96.connector_name, 
	d_mm96.error_code
    from d_m96
    left join d_mm96
	on d_m96.id=d_mm96.message_id
    left join d_mcm96
	on d_m96.id=d_mcm96.message_id
)

select  distinct * from final order by id
