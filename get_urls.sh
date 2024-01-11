cat alive_subs.txt | waybackurls >> url1.txt
cat alive_subs.txt | gau --threads 5 --blacklist png,jpg,gif --o gau_result.txt
cat gau_result.txt >> url1.txt
rm gau_result.txt
katana -list alive_links.txt >> url1.txt
cat url1.txt | sort -u >> urls.txt
rm url1.txt
cat urls.txt | uro >> uniq_urls.txt
                                            
