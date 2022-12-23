with d_m68 as (
	select
		id,
		processed
	from mirth_dw.public.d_m68

),

d_mcm68 as (
	select 
	      "ACTION",
	      message_id
	       from mirth_dw.public.d_mcm68
),

d_mm68 as (
	select
		message_id,
		received_date,
		response_date,
		connector_name,
		error_code
	from mirth_dw.public.d_mm68
),

final as (

	select  
	d_m68.id,
	d_m68.processed,
	d_mm68.received_date,
	d_mcm68."ACTION", 
	d_mm68.response_date,
	d_mm68.connector_name, 
	d_mm68.error_code
    from d_m68
    left join d_mm68
	on d_m68.id=d_mm68.message_id
    left join d_mcm68
	on d_m68.id=d_mcm68.message_id
)

select  distinct * from final order by id
