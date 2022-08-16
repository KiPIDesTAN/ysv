# Yaml Schema Validation

A repo to validate yaml files against their referenced yaml schema. The schema is identified via the $schema key, as shown in the example below.

```yaml
$schema: https://azuremlschemas.azureedge.net/latest/batchEndpoint.schema.json
name: mybatchedp
description: my sample batch endpoint
auth_mode: aad_token
```

The schema_validation.sh file accepts a folder and path to the temp directory to use. It looks for all files with the .yml extension in the given folder. For each file found, the $schema value is downloaded and the schema of the file is validated against the downloaded file.

0 is returned on success. A non-zero value is returned on failure.

# Requirements

1. [JSONSchema](https://github.com/python-jsonschema/jsonschema)
2. [YQ](https://github.com/mikefarah/yq)

# Example execution

```bash
./schema_validation.sh examples /tmp
```