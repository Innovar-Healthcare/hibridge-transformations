with d_m59 as (
	select
		id,
		processed
	from mirth_dw.public.d_m59

),

d_mcm59 as (
	select
		message_id,
		status
	from mirth_dw.public.d_mcm59
),

d_mm59 as (
	select
		message_id,
		received_date,
		response_date,
		connector_name,
		error_code
	from mirth_dw.public.d_mm59
),

final as (

	select  
	d_m59.id,
	d_m59.processed,
	d_mm59.received_date,
	d_mcm59.status, 
	d_mm59.response_date,
	d_mm59.connector_name, 
	d_mm59.error_code
    from d_m59
    left join d_mm59
	on d_m59.id=d_mm59.message_id
    left join d_mcm59
	on d_m59.id=d_mcm59.message_id
)

select  distinct * from final order by id