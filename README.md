# NEXT-GEN Dhan Trading Automation


Manual GitHub Actions workflows to run Dhan scripts.


## Usage
1. **instrument.sh** → download API scrip master
2. **order.sh** → place a manual order


### Run Manually
1. Go to **Actions** tab
2. Select **Run Instrument Script** or **Run Order Script**
3. Fill input parameters for order script:
- Strike
- CE/PE
- Price


### Required GitHub Secrets
- `ACCESS_TOKEN`
- `DHAN_CLIENT_ID