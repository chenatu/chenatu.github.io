---
title: 数据分析领域的MultiAgent设计
date: 2025-10-30T21:28:13+08:00
lastmod: 2025-10-30T21:28:13+08:00
draft: true
tags: []
categories:
  - Agent
  - 数据分析
description: ""
cover:
  image: ""
  alt: ""
  caption: ""
---
## 为何需要MultAgent架构设计

有很多优秀的文章深入讨论的MultiAgent架构的价值和设计，建议大家阅读: 

- [Effective context engineering for AI agents from Anthropic Blog](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)
- [How we built our multi-agent research system from Anthropic Blog](https://www.anthropic.com/engineering/multi-agent-research-system  )
- [Don’t Build Multi-Agents from Cognition AI Blog](https://cognition.ai/blog/dont-build-multi-agents#principles-of-context-engineering)

MultiAgent架构的价值主要体现在：

1. **上下文压缩**: 由于模型上下文窗口限制，以及当模型上下文窗口超过50%的时候，模型推理能力的下降。通过MultiAgent架构，可以把每个Agent处理单独任务的上下文，分解限制在单独的模型上下文窗口内，从而让Agent处理更复杂，步骤更多的任务，并保证模型效能基准。
2. **注意力分配**: 
    <ol type="A">
      <li>
        在Agent处理多步，且步骤目标多样的任务时，中间和后面的步骤，非常容易受到前面步骤推理与工具结果的影响。中间和后续推理结果，会受到前面步骤解法倾向的影响。以一个数据分析问题为例，通常分为三个阶段：
        <ol type="a">
            <li>数据结构与内容探查，了解数据字段元信息以及数据内容分布</li>
            <li>根据数据探查结果，进行数据深入分析</li>
            <li>根据数据分析结果，生成最终的数据分析报告</li>
        </ol>
        在数据探查阶段，模型为了需要了解数据分布，可能会对数据做一些`mean`, `median`, `std`等统计计算，以了解数据的分布情况。由于前序代码的影响，可能增加后续分析过程对数据计算进行统计量计算的概率，但是这些过程很可能对数据分析过程并没有直接帮助，反而会让分析过程陷入对统计量计算分析的纠结。
      </li>
      <li>
        同样的，如果数据步骤多且任务多样，对于不同的任务类型，需要在System Prompt中提出方方面面的要求，由于注意力机制问题，在过程较长的情况下，遵守System Prompt指令的能力会下降，从而导致模型推理结果不符合预期。
      </li>
    </ol>
3. **并行处理**: 当任务步骤比较多，且互相不存在依赖的时候，MultiAgent架构可以并行处理这些步骤，从而提高任务处理效率。

## MultiAgent架构的局限

MultiAgent架构同样一些不可忽视的局限，或者说，在设计上需要比较精巧处理的问题。

1. **不合理的任务分解**: 无论是并行任务处理，还是串行任务处理。如果任务分解不合理，原理上无论单个任务处理的如何“精妙”，都无法解决最终的问题。
    <ol type="A">
    <li>并行任务处理的时候没有遵循MECE原则，导致场景遗漏。</li>
    <li>前个任务的输出作为后个任务的输入，但是后续任务无法根据前一个任务输出完成特定任务。举例：如果前一个任务计算一个细粒度的不可累加指标的细粒度分析，后续任务无法对这个细粒度数据进行上卷分析。</li>
    </ol>
1. **上下文损失**：
   <ol type="A">
    <li>
        任务目标损失: 任务拆解过程中，由于缺乏全局上下文视角，导致给到子Agent的任务目标过于泛化。子Agent采用通用解法，或者是另一个场景的解法，导致合并子Agent的任务时，无法还原为原始任务。举例：原始问题是原始任务：分析电商平台Q4季度高价值客户流失的根本原因，并提出挽回策略。但是拆解的第一子任务是：分析客户流失率。丢失了Q4和高价值客户的两个关键过滤条件。
    </li>
    <li>
    </li>
   </ol>