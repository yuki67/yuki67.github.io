import sys
import re
import os
import shutil
import urllib.parse

nb_filename = sys.argv[1]


# ノートブックをマークダウンに変換
os.system("python -m nbconvert --to markdown --output-dir _posts " + nb_filename)

# デフォルトの状態だと数式が$$...$$となっていて中央寄せになるので
# 行頭にある"$$"を"\$$\displaystyle "に変更する
# 本当に中央寄せを使いたいときは" $$"などにすればOK
# コメントアウトしてあるの2箇所はpandoc/はてなブログ用の設定
str = ""
preserving_images = []
md_filename = "_posts/" + os.path.split(nb_filename)[-1][:-5] + "md"
with open(md_filename, encoding="utf-8") as f:
    for line in f.readlines():
        line = re.sub(r"^\$\$", r"\$$\displaystyle ", line)
        # line = line.replace("$$", r"$\displaystyle ", 1).replace("$$", "$", 1)
        line = re.sub(r"\|", r"\middle| ", line)
        if ".png" in line:
            # 画像があったらURLを差し替える
            preserving_images.append(urllib.parse.unquote(line))
            line = urllib.parse.unquote(line)
            print(line)
            if not ("(" in line and ")" in line):
                continue
            left = line.index("(")
            line = line[:left + 1] + "/images/" + line[left + 1:]
            # line = line[:left + 1] + "https://github.com/yuki67/yuki67.github.io/blob/master/images/" + line[left + 1:-2] + "?raw=true" + ")\n"
            print(line)
        str += line

# 書き込む
with open(md_filename, "w", encoding="utf-8") as f:
    f.write(str)

# nbconvertで作られる画像ファイルをimagesフォルダへ移動
# 使っていないファイルは消す
dir_name = os.path.split(nb_filename)[-1][:-6] + "_files"
shutil.rmtree(os.path.join("images", dir_name), ignore_errors=True)
shutil.move(os.path.join("_posts", dir_name), "images")
for f in os.listdir(os.path.join("images", dir_name)):
    # 線形探索
    for line in preserving_images:
        if f in line:
            print("preserving", f)
            break
    else:
        print("removing", f)
        os.remove(os.path.join("images", dir_name, f))
