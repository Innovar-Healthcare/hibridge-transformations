with d_m26 as (
	select
		id,
		processed
	from mirth_dw.public.d_m26

),

d_mcm26 as (
	select 
              message_id,
              "TYPE",
              "SOURCE"
	       from mirth_dw.public.d_mcm26
),

d_mm26 as (
	select
		message_id,
		received_date,
		response_date,
		connector_name,
		error_code
	from mirth_dw.public.d_mm26
),

final as (

	select  
	d_m26.id,
	d_m26.processed,
	d_mm26.received_date,
	d_mm26.response_date,
	d_mcm26."TYPE",
	d_mcm26."SOURCE",
	d_mm26.connector_name, 
	d_mm26.error_code
    from d_m26
    left join d_mm26
	on d_m26.id=d_mm26.message_id
    left join d_mcm26
	on d_m26.id=d_mcm26.message_id
)

select  distinct * from final order by id
