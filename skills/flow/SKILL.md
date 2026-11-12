---
name: flow
description: RnDStack 总流程。说明一个想法从提出到交付要经过哪些阶段、每个阶段用 gstack 还是 pstack 的哪个技能、阶段之间交接什么。用户问"下一步该做什么""该用哪个技能""怎么开始一个新功能"，或提到 rndstack、/rndstack:flow 时使用。
---

# RnDStack 流程

RnDStack 不重复 gstack 和 pstack 已有的能力，只规定三件事：按什么顺序用它们，阶段之间交接什么，哪些决定必须由人来做。

## 阶段

| 阶段 | 用什么 | 产出 | 进入下一阶段的条件 |
|---|---|---|---|
| 1. 定题 | gstack `/office-hours` | 设计文档、会话记录 | 用户批准设计文档 |
| 2. 事实核对 | `rndstack:evidence-first` | 一页依赖事实记录 | 设计所依赖的外部接口都有依据 |
| 3. 评审 | gstack `/autoplan` | 评审记录、待决事项 | 用户在最终关口答复（见 `rndstack:decision-gate`） |
| 4. 定稿 | `rndstack:consolidate-spec` | 合并后的单一正文、评审存档 | 正文里没有互相取代的说法 |
| 5. 实现 | pstack `/pstack:poteto-mode`，配合 `/pstack:tdd`、`/pstack:architect` | 代码和测试 | 测试通过，行为有证据 |
| 6. 检查 | gstack `/review`、`/qa` | 审查发现及修复 | 没有未处理的阻塞问题 |
| 7. 交付 | gstack `/ship` | PR | 用户合并 |
| 8. 沉淀 | `rndstack:distill` | 新的或更新的 RnDStack 技能 | 经验已写成可复用的规则 |

全程用 `rndstack:session-log` 把过程记进仓库。

## 规则

- **第 2 阶段不能跳到第 3 阶段之后。** 评审再细，也发现不了设计建立在不存在的接口上；只有去读真实的代码才能发现。
- **分工**：gstack 负责两头（想清楚、检查、交付），pstack 负责中间（写代码）。两者不冲突，不要用一个去替代另一个。
- **每个阶段结束都提交并推送。** 云端环境是临时的，没推送的工作会丢。
- **改变用户已定方向的建议不自动采纳**，统一留到关口由用户决定。

## 开始之前

- 确认 gstack 和 pstack 已安装（云端见 `rndstack:cloud-setup`）。
- 第一次使用 pstack 先运行 `/pstack:setup-pstack` 选择模型。
- 先估算代价再开始重流程：`/autoplan` 完整跑一遍要读几千行评审方法并派出多个独立审阅，耗时和用量都明显高于它自己给出的估计。小改动直接用 `/review` 即可。
