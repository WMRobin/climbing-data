include("read_json_files.jl")
va_areas = jsl_to_df("southeast/va-areas.jsonlines");
va_routes = jsl_to_df("southeast/va-routes.jsonlines");

names(va_routes)