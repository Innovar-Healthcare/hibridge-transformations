with d_m95 as (
	select
		id,
		processed
	from mirth_dw.public.d_m95

),

d_mcm95 as (
	select 
              message_id
	       from mirth_dw.public.d_mcm95
),

d_mm95 as (
	select
		message_id,
		received_date,
		response_date,
		connector_name,
		error_code
	from mirth_dw.public.d_mm95
),

final as (

	select  
	d_m95.id,
	d_m95.processed,
	d_mm95.received_date,
	d_mm95.response_date,
	d_mm95.connector_name, 
	d_mm95.error_code
    from d_m95
    left join d_mm95
	on d_m95.id=d_mm95.message_id
    left join d_mcm95
	on d_m95.id=d_mcm95.message_id
)

select  distinct * from final order by id
