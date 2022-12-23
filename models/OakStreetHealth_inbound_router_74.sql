with d_m74 as (
	select
		id,
		processed
	from mirth_dw.public.d_m74

),

d_mcm74 as (
	select 
	      "ACTION",
	      message_id
	       from mirth_dw.public.d_mcm74
),

d_mm74 as (
	select
		message_id,
		received_date,
		response_date,
		connector_name,
		error_code
	from mirth_dw.public.d_mm74
),

final as (

	select  
	d_m74.id,
	d_m74.processed,
	d_mm74.received_date,
	d_mcm74."ACTION", 
	d_mm74.response_date,
	d_mm74.connector_name, 
	d_mm74.error_code
    from d_m74
    left join d_mm74
	on d_m74.id=d_mm74.message_id
    left join d_mcm74
	on d_m74.id=d_mcm74.message_id
)

select  distinct * from final order by id
