with d_m92 as (
	select
		id,
		processed
	from mirth_dw.public.d_m92

),

d_mcm92 as (
	select 
              message_id
	       from mirth_dw.public.d_mcm92
),

d_mm92 as (
	select
		message_id,
		received_date,
		response_date,
		connector_name,
		error_code
	from mirth_dw.public.d_mm92
),

final as (

	select  
	d_m92.id,
	d_m92.processed,
	d_mm92.received_date,
	d_mm92.response_date,
	d_mm92.connector_name, 
	d_mm92.error_code
    from d_m92
    left join d_mm92
	on d_m92.id=d_mm92.message_id
    left join d_mcm92
	on d_m92.id=d_mcm92.message_id
)

select  distinct * from final order by id
