with d_m47 as (
	select
		id,
		processed
	from mirth_dw.public.d_m47

),

d_mcm47 as (
	select
		message_id,
		client_id
	from mirth_dw.public.d_mcm47
),

d_mm47 as (
	select
		message_id,
		received_date,
		response_date,
		connector_name,
		error_code
	from mirth_dw.public.d_mm47
),

final as (

	select DISTINCT 
	d_m47.id,
	d_m47.processed,
	d_mm47.received_date,
	d_mcm47.client_id,
	d_mm47.response_date,
	d_mm47.connector_name, 
	d_mm47.error_code
    from d_m47
    left join d_mm47
	on d_m47.id=d_mm47.message_id
    left join d_mcm47
	on d_m47.id=d_mcm47.message_id
)

select * from final
