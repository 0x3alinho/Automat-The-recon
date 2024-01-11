        # host discoery
#input_file=cidr.txt

#while IFS= read -r cidr; do
 #   nmap -n -Pn -sS --top-ports 100 "$cidr" | grep "for" | cut -d " " -f 5 >> IP.txt
#done < "$input_file"
############################################################################

        # get ips from domains
# Process each domain in the input file
#./domians_to_ips.sh all_subs.txt ips.txt
###############################################################################

        # start the scaning wiht masscan
masscan -p1-65535 -iL ips.txt  10000 -oG masscan_result.txt

        # start scan with naabut
naabu -l ips.txt -p -o naabu_scan_results.txt
                                                  
