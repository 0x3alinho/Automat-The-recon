        # scan the alive_links.txt & urls.txt with nuclei 

cat alive_links.txt | nuclei -t ~/nuclei-templates -es info,unknown -etags ssl,network -o nuclei_result1.txt
cat urls.txt | nuclei -t ~/nuclei-templates -es info,unknown -etags ssl,network -o nuclei_result2.txt
