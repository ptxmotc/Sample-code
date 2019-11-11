# Usage

`ptxget API_PATH`

# Dependency

- curl
- openssl

# Environment

- `PTX_APP_ID` - L1/L2 Application ID
- `PTX_APP_KEY` - L1/L2 Application KEY

# Example

```sh
env PTX_APP_ID=YOUR_ID \
  PTX_APP_KEY=YOUR_KEY \
  ptxget '/v2/Air/FIDS/Airport/Departure?\$top=3'
```
