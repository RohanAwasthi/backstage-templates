project = "${{ values.projectName}}"
{%- if  values.projectEnvironment %}
environment = "${{ values.projectEnvironment}}"
{%- else %}
environment = "dev"
{%- endif %}
{%- if  values.azLocation %}
location = "${{ values.azLocation}}"
{%- else %}
location = "East US"
{%- endif %}
