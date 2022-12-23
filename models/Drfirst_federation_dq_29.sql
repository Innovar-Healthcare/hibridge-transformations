with d_m29 as (
	select
		id,
		processed
	from mirth_dw.public.d_m29

),

d_mcm29 as (
	select 
              message_id,
	      "TYPE",
	      "SOURCE"
	       from mirth_dw.public.d_mcm29
),

d_mm29 as (
	select
		message_id,
		received_date,
		response_date,
		connector_name,
		error_code
	from mirth_dw.public.d_mm29
),

final as (

	select  
	d_m29.id,
	d_m29.processed,
	d_mm29.received_date,
	d_mcm29."TYPE",
	d_mcm29."SOURCE", 
	d_mm29.response_date,
	d_mm29.connector_name, 
	d_mm29.error_code
    from d_m29
    left join d_mm29
	on d_m29.id=d_mm29.message_id
    left join d_mcm29
	on d_m29.id=d_mcm29.message_id
)

select  distinct * from final order by id
