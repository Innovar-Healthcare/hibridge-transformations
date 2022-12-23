with d_m81 as (
	select
		id,
		processed
	from mirth_dw.public.d_m81

),

d_mcm81 as (
	select 
              message_id
	       from mirth_dw.public.d_mcm81
),

d_mm81 as (
	select
		message_id,
		received_date,
		response_date,
		connector_name,
		error_code
	from mirth_dw.public.d_mm81
),

final as (

	select  
	d_m81.id,
	d_m81.processed,
	d_mm81.received_date,
	d_mm81.response_date,
	d_mm81.connector_name, 
	d_mm81.error_code
    from d_m81
    left join d_mm81
	on d_m81.id=d_mm81.message_id
    left join d_mcm81
	on d_m81.id=d_mcm81.message_id
)

select  distinct * from final order by id
