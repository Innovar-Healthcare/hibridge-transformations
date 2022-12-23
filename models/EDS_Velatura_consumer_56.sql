with d_m56 as (
	select
		id,
		processed
	from mirth_dw.public.d_m56

),

d_mcm56 as (
	select 
              message_id,
	      C28
	       from mirth_dw.public.d_mcm56
),

d_mm56 as (
	select
		message_id,
		received_date,
		response_date,
		connector_name,
		error_code
	from mirth_dw.public.d_mm56
),

final as (

	select  
	d_m56.id,
	d_m56.processed,
	d_mm56.received_date,
	d_mcm56.C28,
	d_mm56.response_date,
	d_mm56.connector_name, 
	d_mm56.error_code
    from d_m56
    left join d_mm56
	on d_m56.id=d_mm56.message_id
    left join d_mcm56
	on d_m56.id=d_mcm56.message_id
)

select  distinct * from final order by id