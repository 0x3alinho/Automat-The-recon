
        # host discoery
input_file=cidr.txt

while IFS= read -r cidr; do
    nmap -n -Pn -sS "$cidr" | grep "for" | cut -d " " -f 5 >> IP.txt
done < "$input_file"
############################################################################

        # get ips from domains
# Process each domain in the input file
input_file=all_subs.txt
while IFS= read -r domain; do
    # Use dig to get the IP address for the domain
    ip_address=$(dig +short "$domain")

        echo -n "$ip_address" >> IP.txt
done < "$input_file"

cat IP.txt | sort -u >> ips.txt
rm IP.txt
###############################################################################

        # start the scaning wiht masscan
masscan -p1-65535 -iL ips.txt -max-rate 10000 -oG masscan_result.txt

        # start scan with naabu
naabu -iL ips.txt -p -o naabu_scan_results.txt


