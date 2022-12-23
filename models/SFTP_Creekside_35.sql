with d_m35 as (
	select
		id,
		processed
	from mirth_dw.public.d_m35

),

d_mcm35 as (
	select 
              message_id,
              "TYPE",
              "SOURCE"
	       from mirth_dw.public.d_mcm35
),

d_mm35 as (
	select
		message_id,
		received_date,
		response_date,
		connector_name,
		error_code
	from mirth_dw.public.d_mm35
),

final as (

	select  
	d_m35.id,
	d_m35.processed,
	d_mm35.received_date,
	d_mm35.response_date,
	d_mcm35."TYPE",
	d_mcm35."SOURCE",
	d_mm35.connector_name, 
	d_mm35.error_code
    from d_m35
    left join d_mm35
	on d_m35.id=d_mm35.message_id
    left join d_mcm35
	on d_m35.id=d_mcm35.message_id
)

select  distinct * from final order by id
