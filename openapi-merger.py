import os
import yaml

# Define paths
api_dir = "./apis"  # Directory with individual OpenAPI YAML files
output_file = "merged_openapi.yaml"  # Output merged file

# Initialize the base OpenAPI structure
merged_spec = {
    "openapi": "3.0.0",
    "info": {
        "title": "Ancile Insurance Platform API",
        "description": "API documentation for Ancile Insurance Platform.",
        "version": "1.0.0"
    },
    "paths": {},
    "components": {
        "schemas": {}
    },
    "tags": []
}

# Helper to merge paths and schemas, adding a tag for each service
def merge_openapi_spec(file_path, service_tag):
    with open(file_path, 'r') as f:
        api_spec = yaml.safe_load(f)

        # Add tag information
        if "tags" not in merged_spec:
            merged_spec["tags"] = []

        merged_spec["tags"].append({"name": service_tag})

        # Merge paths with the tag specified
        for path, path_data in api_spec.get("paths", {}).items():
            if path not in merged_spec["paths"]:
                merged_spec["paths"][path] = {}

            for method, method_data in path_data.items():
                method_data["tags"] = [service_tag]  # Add tag to method
                merged_spec["paths"][path][method] = method_data

        # Merge schemas (components)
        if "components" in api_spec and "schemas" in api_spec["components"]:
            for schema, schema_data in api_spec["components"]["schemas"].items():
                merged_spec["components"]["schemas"][schema] = schema_data

# Loop through API files in the specified directory
for filename in os.listdir(api_dir):
    if filename.endswith(".yaml") or filename.endswith(".yml"):
        # Derive tag name from filename, e.g., "user_api.yaml" -> "User"
        service_tag = filename.split("_")[0].capitalize()
        merge_openapi_spec(os.path.join(api_dir, filename), service_tag)

# Write the merged spec to an output YAML file
with open(output_file, "w") as outfile:
    yaml.dump(merged_spec, outfile, sort_keys=False)

print(f"Merged OpenAPI spec written to {output_file}")
