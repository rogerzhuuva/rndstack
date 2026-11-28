# RnDStack

从真实项目工作中沉淀下来的开发方法，打包成 Claude Code 插件。

RnDStack 不重复 [gstack](https://github.com/garrytan/gstack) 和 [pstack](https://github.com/cursor/plugins/tree/main/pstack) 已有的能力。它规定的是：按什么顺序用它们，阶段之间交接什么，哪些决定必须由人来做。

这个仓库只收方法，不收任何项目的具体内容。

## 安装

需要先装好 gstack 和 pstack。然后在 Claude Code 里依次输入：

```
/plugin marketplace add rogerzhuuva/rndstack
```

```
/plugin install rndstack@rndstack
```

云端会话的自动安装见 `skills/cloud-setup/SKILL.md`。

## 在其它代理里用（Grok Bot、Cursor、Codex 等）

技能就是 `skills/<名称>/SKILL.md`，不依赖 Claude Code。两种用法：

- 让代理克隆这个仓库，先读根目录的 `AGENTS.md`，它说明了怎么找技能、技能里点名的 gstack 和 pstack 不在时怎么做同样的事。
- 或者把技能装进代理的技能目录：`scripts/install.sh <目标目录>`。

## 技能

| 技能 | 作用 |
|---|---|
| `/rndstack:flow` | 总流程：从想法到交付的阶段、每个阶段用哪个工具 |
| `/rndstack:evidence-first` | 设计依赖外部接口时，先读真实代码并标注依据 |
| `/rndstack:session-log` | 把讨论和评审过程结构化地记进仓库 |
| `/rndstack:decision-gate` | 哪些事助手自己定，哪些必须用户拍板，怎么一次问清 |
| `/rndstack:consolidate-spec` | 评审后把设计文档合并成单一正文并存档评审记录 |
| `/rndstack:cloud-setup` | 云端会话里保持工具可用，以及常见问题的处理 |
| `/rndstack:delegate-verify` | 把实现交给子代理时怎样切分、写任务说明和验收 |
| `/rndstack:handoff` | 用户离开或挪到云端时怎样交接，怎样攒一张需本人操作的清单 |
| `/rndstack:doubt-to-experiment` | 用实验回答对设计的质疑：预先登记、开发集与测试集分开、测试集只跑一次、报告加可调用代码 |
| `/rndstack:research-doc-review` | 评审科研项目文档：论证、验证、跨文件一致性、前期继承、知识产权覆盖 |
| `/rndstack:distill` | 把新的方法经验沉淀进这个仓库 |

## 与 gstack、pstack 的关系

```
  想法 ──> gstack /office-hours ──> rndstack:evidence-first ──> gstack /autoplan
                                                                    │
                                                    rndstack:decision-gate（用户拍板）
                                                                    │
  交付 <── gstack /ship <── gstack /review、/qa <── pstack 实现 <── rndstack:consolidate-spec

  全程：rndstack:session-log        结束后：rndstack:distill
```

## 许可

MIT
