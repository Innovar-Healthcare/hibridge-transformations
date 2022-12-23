with d_m78 as (
	select
		id,
		processed
	from mirth_dw.public.d_m78

),

d_mcm78 as (
	select 
              message_id
	       from mirth_dw.public.d_mcm78
),

d_mm78 as (
	select
		message_id,
		received_date,
		response_date,
		connector_name,
		error_code
	from mirth_dw.public.d_mm78
),

final as (

	select  
	d_m78.id,
	d_m78.processed,
	d_mm78.received_date,
	d_mm78.response_date,
	d_mm78.connector_name, 
	d_mm78.error_code
    from d_m78
    left join d_mm78
	on d_m78.id=d_mm78.message_id
    left join d_mcm78
	on d_m78.id=d_mcm78.message_id
)

select  distinct * from final order by id
