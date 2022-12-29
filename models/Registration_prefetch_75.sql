with d_m75 as (
	select
		id,
		processed
	from mirth_dw.public.d_m75

),

d_mcm75 as (
	select
		message_id,
		client
	from mirth_dw.public.d_mcm75
),

d_mm75 as (
	select
		message_id,
		received_date,
		response_date,
		connector_name,
		error_code
	from mirth_dw.public.d_mm75
),

final as (

	select DISTINCT 
	d_m75.id,
	d_m75.processed,
	d_mm75.received_date,
	d_mcm75.client,
	d_mm75.response_date,
	d_mm75.connector_name, 
	d_mm75.error_code
    from d_m75
    left join d_mm75
	on d_m75.id=d_mm75.message_id
    left join d_mcm75
	on d_m75.id=d_mcm75.message_id
)

select * from final
