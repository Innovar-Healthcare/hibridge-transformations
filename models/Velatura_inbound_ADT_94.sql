with d_m94 as (
	select
		id,
		processed
	from mirth_dw.public.d_m94

),

d_mcm94 as (
	select 
		"TYPE", 
		provider_id,
		sending_facility,
		receiving_facility,
		sending_application,
		receiving_application,
        message_id
	       from mirth_dw.public.d_mcm94
),

d_mm94 as (
	select
		message_id,
		received_date,
		response_date,
		connector_name,
		error_code
	from mirth_dw.public.d_mm94
),

final as (

	select  
	d_m94.id,
	d_m94.processed,
	d_mm94.received_date,
	d_mcm94."TYPE", 
	d_mcm94.provider_id,
	d_mcm94.sending_facility,
	d_mcm94.receiving_facility,
	d_mcm94.sending_application,
	d_mcm94.receiving_application,
	d_mm94.response_date,
	d_mm94.connector_name, 
	d_mm94.error_code
    from d_m94
    left join d_mm94
	on d_m94.id=d_mm94.message_id
    left join d_mcm94
	on d_m94.id=d_mcm94.message_id
)

select  distinct * from final order by id
