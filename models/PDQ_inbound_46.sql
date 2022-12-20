with d_m46 as (
	select
		id,
		processed
	from mirth_dw.public.d_m46

),

d_mcm46 as (
	select
		message_id,
		client_id
	from mirth_dw.public.d_mcm46
),

d_mm46 as (
	select
		message_id,
		received_date,
		response_date,
		connector_name,
		error_code
	from mirth_dw.public.d_mm46
),

final as (

	select DISTINCT 
	d_m46.id,
	d_m46.processed,
	d_mm46.received_date,
	d_mcm46.client_id,
	d_mm46.response_date,
	d_mm46.connector_name, 
	d_mm46.error_code
    from d_m46
    left join d_mm46
	on d_m46.id=d_mm46.message_id
    left join d_mcm46
	on d_m46.id=d_mcm46.message_id
)

select * from final
