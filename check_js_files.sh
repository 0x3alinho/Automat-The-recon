!/usr/bin/bash

cat urls.txt | grep js | httpx -mc 200 | tee js.txt
nuclei -l js.txt -t ~/nuclei-templates/exposures/ -o js_bugs.txt

inputfile="js.txt"
# Loop through each line in the file
while IFS= read -r url
do
    wget "$url"
done < "$inputfile"
cat *.js | grep -r -E "aws_access_key|aws_secret_key|api key|passwd|pwd|heroku|slack|firebase|swagger|aws_secret_key|aws key|password|ftp password|jdbc|db|sql|secret jet|config|admin|pwd|json|gcp|htaccess|.env|ssh key|.git|access key|secret token|oauth_token|oauth_token_secret|smtp" >> js_grep_result.txt 
rm *.js
#rm js.txt
