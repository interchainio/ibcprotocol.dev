# Website Redirect Setup

This repository contains a script and configuration for setting up redirects for a website. It uses a simple Bash script to automatically create redirect pages in the `dist` directory based on the `_REDIRECTS` file.

## Files

- `redirects_script.sh`: The Bash script that reads the `_REDIRECTS` file and creates redirect HTML files in the `dist` directory.
- `_REDIRECTS`: A file listing the paths and their corresponding redirect URLs.

## Setup

1. **Place the `_REDIRECTS` File**: Ensure the `_REDIRECTS` file is in the root of your repository. This file should list the paths to redirect from and the corresponding URLs to redirect to, one pair per line.

2. **Add the Script**: Place the `redirects_script.sh` in your repository, preferably in a scripts directory.

## Usage

- Update the `_REDIRECTS` file as needed with new redirect pairs.
- Run the `redirects_script.sh` script to generate the redirect pages in the `dist` directory.

## Note

- Ensure the `redirects_script.sh` is executable (`chmod +x redirects_script.sh`).
