論文執筆用のテンプレートファイルを保存します。

# ファイルについて
## manuscript.md
[Pandoc拡張Markdown記法](http://sky-y.github.io/site-pandoc-jp/users-guide/)で執筆します。
gitで管理するメインのファイルです。

## bib.bib
Mendeleyでは`control+E`でエクスポートします。DOIやISBNなど多くのジャーナルでは必要のないものも出力されるため、状況に応じで`grep -v`で整形すると良いでしょう。

## jasn.csl
cslは[ここ](https://github.com/citation-style-language/styles/find/master)から検索できます。1000ファイル以上があるので検索がしにくいです。
今回は一例としてJASNのcslですが、目的のcslを保存しましょう。
なお、デフォルトでは雑誌のフルネームでとても長いファイル名なので、省略したほうが使いやすいです。

## pandoc_style.docx
pandocのデフォルトの出力はcaribliなどを使っていて読みにくいので、スタイルを整えたテンプレートファイルです。
好き嫌いの少ないシンプルなスタイルになっています。

# コマンドについて

文章のコンパイル
```bash
input="test.md"
output="output.docx"
bib="bib.bib"
csl="jasn.csl"

pandoc --reference-docx=pandoc_style.docx \
--filter pandoc-citeproc \
--variable papersize=a4paper  \
--bibliography=${bib} --csl=${csl} \
-s ${input} -o ${output}
```

新しいdocxのテンプレートファイルを作りたい場合
```bash
pandoc --print-default-data-file reference.docx > pandoc_style.docx
```
