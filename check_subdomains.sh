#!/bin/bash

# Define the domain and subdomains
domain="$1"
subdomains=(
    "www"
    "mail"
    "ftp"
    "blog"
    "shop"
    # Add more subdomains here if needed
)

# Check if the correct number of arguments are provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <domain_name>"
    exit 1
fi

# Check if domain is reachable
if ! ping -c 1 "$domain" &> /dev/null; then
    echo "Domain $domain is unreachable."
    exit 1
fi

# Iterate over each subdomain in the list
for subdomain in "${subdomains[@]}"; do
    # Combine subdomain with the main domain
    full_domain="$subdomain.$domain"

    # Check if the subdomain exists
    if host "$full_domain" &> /dev/null; then
        echo "Subdomain $full_domain exists."
    else
        echo "Subdomain $full_domain does not exist."
    fi
done
