---
name: cloud-setup
description: 在 Claude Code 云端会话里安装并保持 gstack、pstack、dstack 可用，以及云端环境特有问题的处理办法：推送被拒、分支显示未推送、合并后的分支怎么继续用。新开云端会话发现技能不在、推送失败、或要给环境配置安装脚本时使用。
---

# 云端环境

云端容器是临时的。每个新会话都从头克隆仓库，装在容器里的东西不会留到下一次。要保留的只有两种办法：推送到仓库，或写进环境的安装脚本。

## 安装脚本

把下面的内容放进云端环境的安装脚本，每个新容器会自动执行。脚本以失败不阻塞会话的方式编写。

```bash
#!/bin/bash
export HOME="${HOME:-/root}"
export PATH="$HOME/.bun/bin:/opt/node22/bin:$PATH"
G="$HOME/.claude/skills/gstack"
if [ ! -d "$G" ]; then
  git clone --single-branch --depth 1 https://github.com/garrytan/gstack.git "$G" || true
fi
if [ -d "$G" ]; then
  (cd "$G" && ./setup --no-browser -q </dev/null) || echo "gstack setup failed"
fi
if command -v claude >/dev/null; then
  claude plugin marketplace add cursor/plugins || true
  claude plugin install pstack@cursor-plugins || echo "pstack install failed"
  claude plugin marketplace add rogerzhuuva/dstack || true
  claude plugin install dstack@dstack || echo "dstack install failed"
fi
exit 0
```

- 模型选择等个人配置写在 `~/.claude/rules/` 下，同样要由安装脚本写出，否则下次会话就没了。
- 改了安装脚本之后，在真正的新会话里看一眼技能列表才算验证过。

## 浏览器

gstack 自带的浏览器下载可能被网络策略拦截。安装时加 `--no-browser`，并把环境变量 `GSTACK_CHROMIUM_PATH` 指向容器里预装的 Chromium。外部网站是否可访问取决于环境的网络白名单。

## 常见问题

| 现象 | 原因 | 处理 |
|---|---|---|
| 推送返回 403，提示没有访问权限 | GitHub 应用没有装到该仓库，或账号关联没刷新 | 用户到 GitHub 连接页面重新关联并确认仓库在允许列表里。重试不会有不同结果，不要反复重试 |
| 推送成功，但检查脚本说分支没有推送 | 浅克隆只跟踪默认分支，本地没有新分支的远程引用 | `git config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'` 然后 `git fetch origin` |
| PR 合并后要在同一分支上继续工作 | 分支落后于默认分支 | `git fetch origin main` 后 `git merge --ff-only origin/main`，再继续提交 |
| 想在用户账号下新建仓库 | 会话只能操作已挂载的仓库 | 请用户在 GitHub 上新建，再把仓库挂到会话 |
| 蓝牙、串口等本机硬件 | 云端容器碰不到用户的设备 | 这部分只能在用户本地运行；云端负责代码、模拟设备上的测试和文档 |

## 规则

- 每完成一段工作就提交并推送，不攒着。
- 不替用户合并 PR，除非用户明确要求。
- 本地电脑上的安装云端改不到，把要运行的命令给用户。
