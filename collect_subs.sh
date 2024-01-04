#!/bin/bash


        # run subfinder

subfinder -dL scope.txt -silent >> all.txt
subfinder -dL scope.txt -recursive -silent -t 200 >> all.txt


        # run amass

#amass enum --passive -df scope.txt 
#amass db -names -df scope.txt >> all.txt


        # run theHarvester

for i in $(cat scope.txt); do
    theHarvester -d $i -b all -f theHarvester_results_$i.html
done

cat theHarvester_results*.xml | grep -oP '<host>\K[^<]+' >> all.txt
rm theHarvester_results* 


        # run assetfinder

cat scope.txt | assetfinder -subs-only >> all.txt


        # run subenum

./subenum.sh -l scope.txt -r -o subenum_out.txt 
rm *-*-*.txt
cat subenum_out.txt | sort -u >> all.txt
rm subenum_out.txt



        # run shosubgo          it need shodan api

for i in cat scope.txt; do shosubgo -d $i -s yumdcgE3IBbaqNY33WkM2xjXZdjEwnr6 >> shodan_result.txt ;done
cat shodan_result.txt >> all.txt
rm shodan_result.txt


        # run security Trails

for i in $(cat scope.txt); do
    curl -s --request GET --url "https://api.securitytrails.com/v1/domain/$i/subdomains?apikey=m1gy2rjKjd-EVpbacD2PPG4zEmCzdSpL" | jq -r '.subdomains[]' | sed "s/$/.$i/" >> trials.txt                                                                                                                                   
done

cat trials.txt | sort -u >> all.txt
rm trials.txt

        # run githup-subs

for i in $(cat scope.txt); do
    github-subdomains -d "$i" -t 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 -raw >> githup_subs.txt
   rm "$i".txt
done

cat githup_subs.txt >> all.txt
rm githup_subs.txt


        # collect sub form crt

 curl -s "https://crt.sh/?q=%25.$1" \
 | grep -oE "[\.a-zA-Z0-9-]+\.$1" \
 | sort -u
 }

 for i in $(cat scope.txt); do
    crt "$i" >> crt.txt
done
cat crt.txt >> all.txt
rm crt.txt


        # collect sub from archive

archive() {
    curl -s "http://web.archive.org/cdx/search/cdx?url=*.$1/*&output=text&fl=original&collapse=urlkey" | awk -F/ '{print $3}' | sort -u
}
for i in $(cat scope.txt); do
    archive "$i" >> archive_subs.txt
done
cat archive_subs.txt >> all.txt
rm archive_subs.txt

        # runbrut_forcing


puredns bruteforce my_wordlist.txt -d scope.txt -w puredns_result.txt

cat puredns_result.txt >> all.txt
rm puredns_result.txt


#collect sub sub domains
#subfinder -dL all.txt -silent >> all.txt
