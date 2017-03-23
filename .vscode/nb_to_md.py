import sys
import re
import os

nb_filename = sys.argv[1]
target = r"^\$\$"
repl = r"\$$\displaystyle "


# ノートブックをマークダウンに変換
os.system("python -m nbconvert --to markdown --output-dir _posts " + nb_filename)

# デフォルトの状態だと数式が$$...$$となっていて中央寄せになるので
# 行頭にある"$$"を"\$$\displaystyle "に変更する
# 本当に中央寄せを使いたいときは" $$"などにすればOK
str = ""
md_filename = "_posts/" + os.path.split(nb_filename)[-1][:-5] + "md"
with open(md_filename, encoding="utf-8") as f:
    for line in f.readlines():
        if re.match(target, line):
            str += re.sub(target, repl, line)
        else:
            str += line

# 書き込む
with open(md_filename, "w", encoding="utf-8") as f:
    f.write(str)

# nbconvertで作られる画像ファイルを削除(いらない)
os.system("rm -r _posts/*_files")
