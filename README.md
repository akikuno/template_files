論文執筆用のテンプレートファイルを保存します。

# ファイルについて
## manuscript.md
[Pandoc拡張Markdown記法](http://sky-y.github.io/site-pandoc-jp/users-guide/)で執筆します。

## bib.bib
Mendeleyでは`control+E`でエクスポートします。DOIやISBNなど多くのジャーナルでは必要のないものも出力されるため、状況に応じで`grep -v`で整形すると良いでしょう。

## jasn.csl
cslは[こちらのGitHubリポジトリ](https://github.com/citation-style-language/styles/find/master)から検索できます。
今回は一例としてJASNのcslですが、目的のcslを保存しましょう。
なお、デフォルトのファイル名は雑誌のフルネームでとても長いので、省略したほうが使いやすいです。

## pandoc_style.docx
pandocのデフォルトの出力はcaribliなどを使っていて読みにくいので、スタイルを整えたテンプレートファイルです。

# コマンドについて

## pandocのバージョン

- pandoc 2.10.1 (2020-09-16 確認)
- pandoc 2.2.3.2 (2019-07-13 確認)

## 改ページ

Pandocでdocxにする際に`\newpage`が反映されないため、外部コマンドをインストールします。  
```sh
type pandoc-docx-pagebreakpy 1> /dev/null ||
pip3 install git+https://github.com/pandocker/pandoc-docx-pagebreak-py
```
https://github.com/pandocker/pandoc-docx-pagebreak-py

## 表について

現状、Pandocはmultiline tablesやgrid tableのみ対応しています。  
テーブルのフォーマットには下記のVS codeの拡張機能が便利です。  
`Table Formatter`  
https://marketplace.visualstudio.com/items?itemName=shuworks.vscode-table-formatter

## 文章のコンパイル

```bash
input="manuscript.md"
output="manuscript.docx"
bib="bib.bib"
csl="jasn.csl"

pandoc -f markdown+emoji \
  --reference-doc=pandoc_style.docx \
  --filter pandoc-citeproc \
  --variable papersize=a4paper  \
  --filter=pandoc-docx-pagebreakpy \
  --bibliography=${bib} --csl=${csl} \
  -s ${input} -o ${output} 2>&1 |
grep -v "Page Break"
```

## 新しいdocxのテンプレートファイルを作りたい場合

以下の`pandoc_style.docx`のスタイルをマニュアルで変更します。

```bash
pandoc --print-default-data-file reference.docx > pandoc_style.docx
```
