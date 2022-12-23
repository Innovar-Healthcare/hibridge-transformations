with d_m27 as (
	select
		id,
		processed
	from mirth_dw.public.d_m27

),

d_mcm27 as (
	select 
              message_id,
              status
	       from mirth_dw.public.d_mcm27
),

d_mm27 as (
	select
		message_id,
		received_date,
		response_date,
		connector_name,
		error_code
	from mirth_dw.public.d_mm27
),

final as (

	select  
	d_m27.id,
	d_m27.processed,
	d_mm27.received_date,
	d_mm27.response_date,
	d_mcm27.status,
	d_mm27.connector_name, 
	d_mm27.error_code
    from d_m27
    left join d_mm27
	on d_m27.id=d_mm27.message_id
    left join d_mcm27
	on d_m27.id=d_mcm27.message_id
)

select  distinct * from final order by id
