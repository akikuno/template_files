#!/bin/bash

input="tmp.md"
output="biblist.docx"
bib="example/export.bib"
csl="example/nature-no-et-al.csl.txt"

cat example/export.bib |
    grep @article |
    cut -d "{" -f 2 |
    tr -d , |
    awk '{print "[@" $1 "]\n"}' |
    cat >"$input"

echo "REFERENCE" >>"$input"

pandoc -f markdown+emoji \
    --reference-doc=pandoc_style.docx \
    --citeproc \
    --variable papersize=a4paper \
    --filter=pandoc-docx-pagebreakpy \
    --bibliography=${bib} --csl=${csl} \
    -s ${input} -o ${output} 2>&1 |
    grep -v "Page Break"

rm "$input"
# END
