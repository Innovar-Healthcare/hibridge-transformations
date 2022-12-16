with d_m45 as (
	select
		id,
		processed
	from mirth_dw.public.d_m45

),

d_mcm45 as (
	select
		message_id,
		client_id
	from mirth_dw.public.d_mcm45
),

d_mm45 as (
	select
		message_id,
		received_date,
		response_date,
		connector_name,
		error_code
	from mirth_dw.public.d_mm45
),

final as (

	select DISTINCT 
	d_m45.id,
	d_m45.processed,
	d_mm45.received_date,
	d_mcm45.client_id,
	d_mm45.response_date,
	d_mm45.connector_name, 
	d_mm45.error_code
    from d_m45
    left join d_mm45
	on d_m45.id=d_mm45.message_id
    left join d_mcm45
	on d_m45.id=d_mcm45.message_id
)

select * from final
