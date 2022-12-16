with d_m49 as (
	select
		id,
		processed
	from mirth_dw.public.d_m49

),

d_mcm49 as (
	select
		message_id,
		client_id
	from mirth_dw.public.d_mcm49
),

d_mm49 as (
	select
		message_id,
		received_date,
		response_date,
		connector_name,
		error_code
	from mirth_dw.public.d_mm49
),

final as (

	select DISTINCT 
	d_m49.id,
	d_m49.processed,
	d_mm49.received_date,
	d_mcm49.client_id,
	d_mm49.response_date,
	d_mm49.connector_name, 
	d_mm49.error_code
    from d_m49
    left join d_mm49
	on d_m49.id=d_mm49.message_id
    left join d_mcm49
	on d_m49.id=d_mcm49.message_id
)

select * from final
