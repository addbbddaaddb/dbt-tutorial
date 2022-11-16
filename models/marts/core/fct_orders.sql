{%- set payment_methods = get_payment_methods() -%}

with
    orders as (select * from {{ ref("stg_orders") }}),

    payments as (select * from {{ ref("stg_payments") }}),

    order_payments as (
        select
            order_id,
            sum(case when status = 'success' then amount end) as amount,
            {%- for payment_method in payment_methods %}
            sum(case when payment_method = '{{payment_method}}' then amount end) as {{ payment_method }}_amount
           
            {%- if not loop.last %},{% endif -%}
            {% endfor %}
        from payments
        group by 1
    ),

    final as (

        select
            orders.order_id,
            orders.customer_id,
            orders.order_date,
            coalesce(order_payments.amount, 0) as amount,
            {% for payment_method in payment_methods -%}
            order_payments.{{ payment_method }}_amount
            {%- for not loop.last %},{% endfor -%}

        from orders
        left join order_payments using (order_id)
    )

select *
from final
