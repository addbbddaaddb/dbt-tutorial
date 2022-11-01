{%- set vars = test() -%}

select
order_id,
{%- for payment_method in vars %}
{{payment_method}}
{%- if not loop.last %},{% endif -%}
{% endfor %}
from {{ ref('raw_payments') }}
group by 1






