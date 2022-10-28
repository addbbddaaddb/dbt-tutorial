{% macro test() %}

{% set query1 %}
select distinct
payment_method
from {{ ref('raw_payments') }}
order by 1
{% endset %}

{% set results = run_query(query1) %}

{{ log(results, info=True) }}

{{ return(results) }}

{% endmacro %}