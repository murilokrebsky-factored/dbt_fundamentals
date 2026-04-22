{%- macro union_tables_by_prefix(database, schema, prefix) -%}

  {%- set query -%}
    select table_name
    from {{ database }}.information_schema.tables
    where table_schema = '{{ schema }}'
      and table_name like '{{ prefix }}%'
    order by table_name
  {%- endset -%}

  {%- set table_names = [] -%}
  {%- if execute -%}
    {%- set results = run_query(query) -%}
    {%- for row in results.rows -%}
      {%- do table_names.append(row[0]) -%}
    {%- endfor -%}
  {%- endif -%}

  {%- if execute and table_names | length == 0 -%}
    {{ exceptions.raise_compiler_error("No tables found with prefix '" ~ prefix ~ "' in " ~ database ~ "." ~ schema) }}
  {%- endif -%}

  {%- for name in table_names -%}
    {%- if not loop.first %}union all {% endif %}
    select * from {{ database }}.{{ schema }}.{{ name }}
  {% endfor -%}

{%- endmacro -%}