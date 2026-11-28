#!/bin/sh
# 把 rndstack 的技能复制到指定的技能目录，每个技能目录名加 rndstack- 前缀。
# 用法：scripts/install.sh <目标目录>
set -eu
[ $# -eq 1 ] || { echo "用法：$0 <目标目录>" >&2; exit 2; }
src=$(cd "$(dirname "$0")/.." && pwd)
dest=$1
mkdir -p "$dest"
for d in "$src"/skills/*/; do
  name=$(basename "$d")
  [ -f "$d/SKILL.md" ] || continue
  out="$dest/rndstack-$name"
  mkdir -p "$out"
  cp -R "$d". "$out"/
  # 技能名与目录名保持一致，避免和别处的同名技能冲突
  sed -i.bak "s/^name: $name\$/name: rndstack-$name/" "$out/SKILL.md" && rm -f "$out/SKILL.md.bak"
  echo "已安装 rndstack-$name"
done
