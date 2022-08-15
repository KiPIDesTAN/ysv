# Yaml Schema Validation

A repo to handle validationg YAML in JSON draft 7 schema format.

# Requirements

1. [JSONSchema](https://github.com/python-jsonschema/jsonschema)
2. [YQ](https://github.com/mikefarah/yq)

# Execution Commands
yq -o json online-deployment.yml > online-deployment.json
jq -r '."$schema"' online-deployment.json