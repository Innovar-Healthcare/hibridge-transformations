with d_m50 as (
	select
		id,
		processed
	from mirth_dw.public.d_m50

),

d_mcm50 as (
	select
		message_id,
		client_id
	from mirth_dw.public.d_mcm50
),

d_mm50 as (
	select
		message_id,
		received_date,
		response_date,
		connector_name,
		error_code
	from mirth_dw.public.d_mm50
),

final as (

	select DISTINCT 
	d_m50.id,
	d_m50.processed,
	d_mm50.received_date,
	d_mcm50.client_id,
	d_mm50.response_date,
	d_mm50.connector_name, 
	d_mm50.error_code
    from d_m50
    left join d_mm50
	on d_m50.id=d_mm50.message_id
    left join d_mcm50
	on d_m50.id=d_mcm50.message_id
)

select * from final
