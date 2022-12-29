with d_m60 as (
	select
		id,
		processed
	from mirth_dw.public.d_m60

),

d_mcm60 as (
	select
		message_id,
		doc_errored,
		doc_returned
	from mirth_dw.public.d_mcm60
),

d_mm60 as (
	select
		message_id,
		received_date,
		response_date,
		connector_name,
		error_code
	from mirth_dw.public.d_mm60
),

final as (

	select  
	d_m60.id,
	d_m60.processed,
	d_mm60.received_date,
	CAST(CAST( d_mcm60.doc_errored AS NUMERIC(19,4)) AS INT8),
	CAST(CAST( d_mcm60.doc_returned AS NUMERIC(19,4)) AS INT8),
	d_mm60.response_date,
	d_mm60.connector_name, 
	d_mm60.error_code
    from d_m60
    left join d_mm60
	on d_m60.id=d_mm60.message_id
    left join d_mcm60
	on d_m60.id=d_mcm60.message_id
)

select * from final 