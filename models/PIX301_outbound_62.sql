with d_m62 as (
	select
		id,
		processed
	from mirth_dw.public.d_m62

),

d_mcm62 as (
	select
		message_id,
		response_code,
		response_status
	from mirth_dw.public.d_mcm62
),

d_mm62 as (
	select
		message_id,
		received_date,
		response_date,
		connector_name,
		error_code
	from mirth_dw.public.d_mm62
),

final as (

	select  
	d_m62.id,
	d_m62.processed,
	d_mm62.received_date,
	d_mcm62.response_code,
	d_mcm62.response_status, 
	d_mm62.response_date,
	d_mm62.connector_name, 
	d_mm62.error_code
    from d_m62
    left join d_mm62
	on d_m62.id=d_mm62.message_id
    left join d_mcm62
	on d_m62.id=d_mcm62.message_id
)

select  distinct * from final where response_code is not null order by id
