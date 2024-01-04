#!/bin/bash
# Script to extract ASNs from domains listed in a file

# Usage: ./get_asn scope.txt

input_file="scope.txt"
output_file="asn.txt"

# Check if input file exists
if [ ! -f "$input_file" ]; then
    echo "Error: $input_file not found."
    exit 1
fi

# Function to get ASN using bgp.he.net with a User-Agent header
get_asn_bgphe() {
    domain="$1"
    # Mimic a web browser with User-Agent header
    curl -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" -s "https://bgp.he.net/dns/$domain" | grep -oP 'AS\d+'
}

# Function to get ASN using amass
get_asn_amass() {
    domain="$1"
    amass intel -org -d "$domain" | grep -oP 'AS\d+'
}

# Process each domain in the input file
while IFS= read -r domain; do
    # Use the method to get ASN with a delay between requests
    asn_bgphe=$(get_asn_bgphe "$domain")
#    asn_amss=$(get_asn_amass "$domain")
    # Print the ASN to the output file
    echo -e "$asn_bgphe\n$asn_amass" >> "$output_file"

done < "$input_file"

# Sort and make the file contain unique ASN numbers
sort -u "$output_file" -o "$output_file"

echo "Unique ASN numbers have been saved to $output_file"
#!/bin/bash

input_file="asn.txt"
output_file="cidr.txt"


while IFS= read -r asn; do
    result=$(whois -h whois.radb.net -- "-i origin $asn" | grep -Eo "([0-9.]+){4}/[0-9]+" | uniq)
    
    if [ -n "$result" ]; then
        echo "$result" >> "$output_file"
    fi        
    
done < "$input_file"

#sort the cidr
sort -u "$output_file" -o "$output_file"
