-- {{target.name}}
-- {{target.role}}
-- {{target.schema}}
-- {{target.type}}
-- {{target.database}}


select
    table_name,
    last_altered
from raw.information_schema.tables
where table_schema = 'jaffle_shop'
order by table_name