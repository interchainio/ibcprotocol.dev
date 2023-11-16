#!/bin/bash

# Fixed file for the redirects list
redirects_file="_REDIRECTS"

# Check if the redirects file exists
if [ ! -f "$redirects_file" ]; then
    echo "Redirects file not found: $redirects_file"
    exit 1
fi

# The base directory where the files will be created
base_dir="dist"

# Read each line from the redirects file
while IFS=' ' read -r path_from url_to
do
    # Full path including the base directory
    full_path="$base_dir/$path_from"

    # Create the directory if it doesn't exist
    mkdir -p "$full_path"

    # Write the HTML content to index.html in the specified directory
    cat <<EOF >"$full_path/index.html"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Redirecting...</title>
    <script type="text/javascript">
        window.location.href = "$url_to";
    </script>
</head>
<body>
    <p>Redirecting to <a href="$url_to">$url_to</a>...</p>
</body>
</html>
EOF

done < "$redirects_file"

echo "Redirection setup complete."
