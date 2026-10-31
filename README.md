# X-Invoice validator script

Script to validate X-Invoices using KoSIT-Validator

## Requirements

- Java
- [KoSIT-Validator](https://github.com/itplr-kosit/validator/)
- [Validator Configuration](https://github.com/itplr-kosit/validator-configuration-xrechnung/)

## Usage

### Preparation

- Install Java
- Download recent version of the standalone KoSIT-Validator `validator-x.x.x-standalone.jar` from https://github.com/itplr-kosit/validator/releases/ \
Place the JAR-file in the same directory as the validate-script (`validate.sh` or `validate.cmd`).
- Download recent version of the validator configuration from https://github.com/itplr-kosit/validator-configuration-xrechnung/ \
Create a directory named `config` in the same directory as the validate-script. \
Extract contents of the ZIP-file directly into the config-directory.

### Validate XML file

```bash
validate.sh "Path-to-file.xml"
```