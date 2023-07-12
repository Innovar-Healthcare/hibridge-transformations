with d_m28 as (
	select
		id,
		processed
	from mirth_dw.public.d_m28

),

d_mcm28 as (
	select 
              message_id,
	      org,
	      med_count,
		  username
	       from mirth_dw.public.d_mcm28
),

d_mm28 as (
	select
		message_id,
		received_date,
		response_date,
		connector_name,
		error_code
	from mirth_dw.public.d_mm28
),

final as (

	select  
	d_m28.id,
	d_m28.processed,
	d_mm28.received_date,
	d_mcm28.org,
	d_mcm28.med_count, 
	d_mm28.response_date,
	d_mm28.connector_name, 
	d_mm28.error_code
    from d_m28
    left join d_mm28
	on d_m28.id=d_mm28.message_id
    left join d_mcm28
	on d_m28.id=d_mcm28.message_id
)

select  distinct * from final order by id
