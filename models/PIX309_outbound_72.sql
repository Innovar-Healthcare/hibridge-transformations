with d_m72 as (
	select
		id,
		processed
	from mirth_dw.public.d_m72

),

d_mcm72 as (
	select
		message_id,
		status
	from mirth_dw.public.d_mcm72
),

d_mm72 as (
	select
		message_id,
		received_date,
		response_date,
		connector_name,
		error_code
	from mirth_dw.public.d_mm72
),

final as (

	select  
	d_m72.id,
	d_m72.processed,
	d_mm72.received_date,
	d_mcm72.status, 
	d_mm72.response_date,
	d_mm72.connector_name, 
	d_mm72.error_code
    from d_m72
    left join d_mm72
	on d_m72.id=d_mm72.message_id
    left join d_mcm72
	on d_m72.id=d_mcm72.message_id
)

select  distinct * from final order by id
