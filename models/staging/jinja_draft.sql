-- Simple loop
{% for i in range(26) %}
    select {{ i }} as number {% if not loop.last %} union all {% endif %}
{% endfor %}


-- Simple if statement
{% set temperature = 22 %}
{% set summer_variable = 'A refreshing lemon sorbet' %}
{% set winter_variable = 'A hot chocolate' %}
{% set spring_variable = 'A steak filet' %}

On a day like this I especially like:
{% if temperature >= 30 %}
    {{ summer_variable }}
{% elif temperature >= 20 and temperature < 30 %}
    {{ spring_variable }}
{% else %}
    {{ winter_variable }}
{% endif %}


-- Lopp with lists
{% set animals = ['rhino', 'cat', 'monkey', 'turtle']%}
{%for animal in animals%}
    select '{{ animal }}' as animal_name {% if not loop.last %} union all {% endif %}
{% endfor %}


-- Loop with lists and if statements
{% set animals = ['rhino', 'cat', 'monkey', 'dog'] %}

{% for animal in animals %}
select
    '{{ animal }}' as animal_name,
    {%- if animal in ['cat', 'dog'] %}
    'pet' as animal_type
    {%- else %}
    'wild' as animal_type
    {%- endif %}
{%- if not loop.last %}
union all
{%- endif %}
{%- endfor %}