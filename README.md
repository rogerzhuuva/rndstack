# DStack

从真实项目工作中沉淀下来的开发方法，打包成 Claude Code 插件。

DStack 不重复 [gstack](https://github.com/garrytan/gstack) 和 [pstack](https://github.com/cursor/plugins/tree/main/pstack) 已有的能力。它规定的是：按什么顺序用它们，阶段之间交接什么，哪些决定必须由人来做。

这个仓库只收方法，不收任何项目的具体内容。

## 安装

需要先装好 gstack 和 pstack。然后在 Claude Code 里依次输入：

```
/plugin marketplace add rogerzhuuva/dstack
```

```
/plugin install dstack@dstack
```

云端会话的自动安装见 `skills/cloud-setup/SKILL.md`。

## 技能

| 技能 | 作用 |
|---|---|
| `/dstack:flow` | 总流程：从想法到交付的阶段、每个阶段用哪个工具 |
| `/dstack:evidence-first` | 设计依赖外部接口时，先读真实代码并标注依据 |
| `/dstack:session-log` | 把讨论和评审过程结构化地记进仓库 |
| `/dstack:decision-gate` | 哪些事助手自己定，哪些必须用户拍板，怎么一次问清 |
| `/dstack:consolidate-spec` | 评审后把设计文档合并成单一正文并存档评审记录 |
| `/dstack:cloud-setup` | 云端会话里保持工具可用，以及常见问题的处理 |
| `/dstack:distill` | 把新的方法经验沉淀进这个仓库 |

## 与 gstack、pstack 的关系

```
  想法 ──> gstack /office-hours ──> dstack:evidence-first ──> gstack /autoplan
                                                                    │
                                                    dstack:decision-gate（用户拍板）
                                                                    │
  交付 <── gstack /ship <── gstack /review、/qa <── pstack 实现 <── dstack:consolidate-spec

  全程：dstack:session-log        结束后：dstack:distill
```

## 许可

MIT
