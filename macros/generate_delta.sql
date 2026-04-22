{% macro generate_delta(env=target.name) %}
    {% set sql %}
        {% if env == 'dev' %}
            INSERT INTO aux.config_delta (delta) VALUES (-30);
        {% elif env == 'prod' %}
            INSERT INTO aux.config_delta (delta) VALUES (-365);
        {% endif %}
    {% endset %}
    {% if env in ('dev', 'prod') %}
        {% do run_query(sql) %}
        {{ log('Delta updated for env: ' ~ env, info=True) }}
    {% else %}
        {{ log('It was not possible to update the delta.', info=True) }}
    {% endif %}
{% endmacro %}
