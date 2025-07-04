
function transform(HealthEvent healthEvent, Out_of_networkItem outofnetworkitem, ProvidersItem providersItem, PaymentsItem paymentsItem, Allowed_amountsItem amountItem, Tin tin) returns HealthEventCsv =>  {
        allowed_amount: paymentsItem.allowed_amount,

        name: healthEvent.reporting_entity_name,
        description: outofnetworkitem.description,

        billing_code_type: outofnetworkitem.billing_code_type,
        billing_code: outofnetworkitem.billing_code,
        billed_charge: providersItem.billed_charge,
        npi: healthEvent.last_updated_on
    };