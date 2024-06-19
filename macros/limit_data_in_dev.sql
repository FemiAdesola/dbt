{% macro limit_data_in_dev(column_name) %}
{% if target.name == 'First Class' %}
where {{column_name}} == shipmode
{% endif %}
{% endmacro %}