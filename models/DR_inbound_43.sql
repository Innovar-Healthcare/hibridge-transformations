with d_m43 as (
	select
		id,
		processed
	from mirth_dw.public.d_m43

),

d_mcm43 as (
	select
		message_id,
		client_id
	from mirth_dw.public.d_mcm43
),

d_mm43 as (
	select
		message_id,
		received_date,
		response_date,
		connector_name,
		error_code
	from mirth_dw.public.d_mm43
),

final as (

	select DISTINCT 
	d_m43.id,
	d_m43.processed,
	d_mm43.received_date,
	d_mcm43.client_id,
	d_mm43.response_date,
	d_mm43.connector_name, 
	d_mm43.error_code
    from d_m43
    left join d_mm43
	on d_m43.id=d_mm43.message_id
    left join d_mcm43
	on d_m43.id=d_mcm43.message_id
)

select * from final
