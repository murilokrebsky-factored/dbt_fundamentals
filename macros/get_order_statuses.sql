{% macro get_order_statuses() %}
    {#
        Returns all distinct order statuses from the orders source table.
        Used to dynamically pivot or filter without hardcoding status values.
    #}
    {% set query %}
        select distinct status
        from {{ source('jaffle_shop', 'orders') }}
        order by 1
    {% endset %}

    {% set statuses = [] %}
    {% if execute %}
        {% set results = run_query(query) %}
        {% for row in results.rows %}
            {% do statuses.append(row[0]) %}
        {% endfor %}
    {% endif %}
    {% for status in statuses %}
        {{ log("Status: " ~ status, info=true) }}
    {% endfor %}
    {{ return(statuses) }}
{% endmacro %}