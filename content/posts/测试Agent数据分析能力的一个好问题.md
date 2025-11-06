---
title: 测试Agent数据分析能力的一个好问题
slug: testing-agent-data-analysis-capabilities
date: 2025-07-30T21:28:13+08:00
lastmod: 2025-07-30T21:28:13+08:00
draft: false
tags: ["Agent", "数据分析"]
categories:
  - 文章
description: ""
cover:
  image: ""
  alt: ""
  caption: ""
---
## 当前主流Benchmark在测试数据分析能力方面的问题

目前，各类通用Agent比较侧重于通用能力的刷榜能力建设。比较典型的Benchmark，例如：

- [GAIA Benchmark](https://huggingface.co/spaces/gaia-benchmark/leaderboard)
- [τ‑bench](https://github.com/sierra-research/tau-bench)

此外也有一些数据分析领域的Benchmark，例如：

- [DABstep](https://huggingface.co/datasets/adyen/DABstep)
- [DataSciBench](https://arxiv.org/abs/2502.13897)

但是，这些Benchmark在测试数据分析能力方面存在一些问题，以GAIA Benchmark为例， 它主要问题都是做关于excel的基础分析，例如,validation set的第6, 54，76，89，93，116题。基本都是根据问题要求定位到数据，再进行简单计算。

而专门的数据分析Benchmark，以DABstep为例，问题也比较直接，离公司运营业务需要用到的数据分析能力比较远

## 实际场景需要的数据能力

无论面对的是excel表格还是SQL数据集，业务上用到的分析能力可以分为如下几类：

1. 基础分析：聚合，分组，过滤，排序
2. 进阶分析：同环比，占比，TopN
3. 洞察分析：归因，异常检测，预测

同时也最好能够模拟一个分析师实际的数据分析过程

## 一个好问题

在这里，我提出一个比较好的测试数据分析能力的问题
> 2018年8月，毛利率为什么下跌？

该问题关联的数据为：[商品销售宽表数据集.xlsx](/files/商品销售宽表数据集.xlsx)，大家可以下载直接进行分析，或者做成一个SQL数据集进行分析。

该问题的采分点如下：

1. 找到零食品类异常 +1
2. 找到德芙巧克力 +1
3. 找到长沙梅溪湖店 +1
4. 找到订单异常 +1
5. 去掉异常后，发现毛利率跌幅在异常范围内 +1

这道题综合体现了：基础分析，同环比，归因下钻，反向分析等能力。同时也能够比较好地还原一个真实的数据分析师的异常数据排查过程。

<!--more-->
