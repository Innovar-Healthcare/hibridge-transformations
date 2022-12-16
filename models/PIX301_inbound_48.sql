with d_m48 as (

    select * from {{ ref('d_m48') }}

),

final as (

	select DISTINCT 
	d_m48.id,
	d_m48.processed,
	d_mm48.received_date,
	d_mcm48.client_id,
	d_mm48.response_date,
	d_mm48.connector_name, 
	d_mm48.error_code
    from d_m48
    left join d_mm48
	on d_m48.id=d_mm48.message_id
    left join d_mcm48
	on d_m48.id=d_mcm48.message_id
)

select * from final
