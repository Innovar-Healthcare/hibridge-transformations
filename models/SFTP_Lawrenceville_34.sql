with d_m34 as (
	select
		id,
		processed
	from mirth_dw.public.d_m34

),

d_mcm34 as (
	select 
              message_id,
              "TYPE",
              "SOURCE"
	       from mirth_dw.public.d_mcm34
),

d_mm34 as (
	select
		message_id,
		received_date,
		response_date,
		connector_name,
		error_code
	from mirth_dw.public.d_mm34
),

final as (

	select  
	d_m34.id,
	d_m34.processed,
	d_mm34.received_date,
	d_mm34.response_date,
	d_mcm34."TYPE",
	d_mcm34."SOURCE",
	d_mm34.connector_name, 
	d_mm34.error_code
    from d_m34
    left join d_mm34
	on d_m34.id=d_mm34.message_id
    left join d_mcm34
	on d_m34.id=d_mcm34.message_id
)

select  distinct * from final order by id
