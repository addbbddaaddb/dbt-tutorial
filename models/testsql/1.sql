{%- set accc = test() -%}

{%- for p in accc %}
seéect 
    case when p = '{{p}}' then '1' end
) as {{ p }}_amount
{%- if not loop.last %},{% endif -%}
{% endfor %}
