// ===== 主题色 =====
#let primary = rgb("#2B5EA7")    // 深蓝 - 姓名、section 标题
#let accent = rgb("#3A7BD5")     // 亮蓝 - 链接、项目标题
#let subtle = rgb("#475569")     // 灰蓝 - 日期、次要信息

// 页面设置
#set page(
  paper: "a4",
  margin: (top: 1cm, bottom: 0.5cm, left: 1cm, right: 1cm),
  numbering: none,
)

// 基础字体设置
#set text(font: ("Inter", "PingFang SC"), size: 11pt, lang: "zh", fill: rgb("#1a1a1a"))
#show raw: set text(font: "JetBrains Mono")
#set par(leading: 0.55em, first-line-indent: 0em)

// 列表样式 - 用主题色圆点
#set list(marker: text(fill: primary)[•], indent: 0.3em, body-indent: 0.5em, spacing: 0.4em)

// 链接统一用 accent 色
#show link: it => text(fill: accent)[#it]

// ===== 工具函数 =====

// 带下划线的超链接
#let resume-url(url, body) = {
  link(url, underline(stroke: 0.5pt + accent, offset: 2pt, body))
}

// section 标题（主题色 + 图标 + 主题色分割线）
#let section-title(icon, title) = {
  v(0.25em)
  block(width: 100%)[
    #text(size: 13pt)[#icon] #h(0.2em) #text(font: ("Inter", "PingFang SC"), size: 14pt, weight: "bold", fill: primary)[#title]
    #v(-0.45em)
    #line(length: 100%, stroke: 1.2pt + primary)
  ]
  v(-0.25em)
}

// 项目条目（标题 + 右侧日期），使用 grid 防止重叠
#let resume-item(title, subtitle: none, date: none) = {
  v(0.3em)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    text(size: 12pt)[
      #text(font: ("Inter", "PingFang SC"), weight: "bold")[#title]
      #if subtitle != none [
        #h(0.3em) #text(fill: subtle)[|] #h(0.3em) #emph[#subtitle]
      ]
    ],
    if date != none { text(size: 11pt, fill: subtle)[#date] },
  )
}

// ===== 简历正文 =====

// 照片定位到右上角
#place(top + right, dy: -0.5cm, box(
  clip: true,
  radius: 4pt,
  image("my.jpg", width: 2.4cm, height: 3.2cm),
))

// 姓名
#align(center, text(font: ("Inter", "PingFang SC"), size: 22pt, weight: "bold", fill: primary)[吴奕民])

#v(-0.4em)

// 联系方式
#align(center, text(size: 10.5pt, fill: rgb("#444"))[
  (+86) 173-2677-1745 #h(0.6em) #text(fill: primary)[|] #h(0.6em) #resume-url("mailto:ymwu.ai@gmail.com")[ymwu.ai\@gmail.com] #h(0.6em) #text(fill: primary)[|] #h(0.6em) #resume-url("https://github.com/kosthi")[github.com/kosthi]
])

// ===== 教育经历 =====

#section-title(emoji.mortarboard, [教育经历])

#resume-item(
  [沈阳工业大学],
  subtitle: [*计算机科学与技术*],
  date: [2021.09—2025.06],
)

GPA: 3.4/4.0（专业前 10%）

// ===== 专业技能 =====

#section-title(emoji.wrench, [专业技能])

*C/C++*、*Python (PyTorch)*、*Go* #h(0.5em) | #h(0.5em) 数据结构与算法、操作系统、计算机网络、数据库原理

// ===== 竞赛获奖 =====

#section-title(emoji.trophy, [竞赛获奖])

#grid(
  columns: (1fr, 1.15fr),
  column-gutter: 1.5em,
  row-gutter: 0.4em,
  [- 2023年美国大学生数学建模竞赛 *国际一等奖*],
  [- 第四届OceanBase 数据库大赛 *全国二等奖*（3/1212）],
  [- 2024年全国大学生信息安全竞赛 *国家二等奖*],
  [- 2024年计算机系统能力大赛-数据库赛道 *全国一等奖*（2/325）],
)

// ===== 发表论文 =====

#section-title(emoji.page, [发表论文])

#resume-item(
  [LiteQG: Towards Scalable and Memory-Efficient Graph-Based Approximate Nearest Neighbor Search],
  date: [ICIC 2025],
)

- 负责图索引构建与检索算法的核心实现，包括基于 HNSW 的邻居选择策略改进与启发式剪枝优化。
- 设计并实现向量量化压缩方案（SQ/PQ），在标准数据集上将内存占用降低的同时保持 0.99 以上召回率。
- 完成大规模数据集上的性能基准测试与对比实验，验证了 LiteQG 在可扩展性和内存效率上的优势。

// ===== 项目经历 =====

#section-title(emoji.star, [项目经历])

#resume-item(
  [斯坦福 CS336 大语言模型入门],
  subtitle: [#resume-url("https://github.com/kosthi/cs336")[GitHub]],
  date: [2025.01—至今],
)

- 从零实现完整的 Transformer 语言模型，包括 *RoPE* 位置编码、*RMSNorm*、*SwiGLU* 激活、因果多头自注意力等核心组件，并实现 BPE 分词器、AdamW 优化器与余弦学习率调度。
- 实现分布式训练优化，包括 *FlashAttention*（PyTorch/Triton）、*DDP* 梯度同步与分桶策略、*优化器状态分片*，降低多卡训练的通信开销与显存占用。
- 实现大模型对齐技术，包括 *SFT* 监督微调、*DPO* 直接偏好优化与 *GRPO* 群体相对策略优化，完成奖励归一化、策略梯度损失计算与 clip 损失等核心算法。

#resume-item(
  [OpenACE 代码上下文检索增强引擎],
  subtitle: [#resume-url("https://github.com/Kosthi/OpenACE")[GitHub]],
  date: [2025.02—至今],
)

- 基于 Rust 实现多信号代码检索引擎，集成 *Tantivy* BM25 全文检索、*usearch* HNSW 向量相似度搜索与 SQLite 图遍历三路信号，通过 *RRF* 算法融合排序，单信号故障自动降级。
- 使用 *tree-sitter* 实现多语言（Python/TypeScript/Rust/Go/Java）AST 解析，提取符号与调用关系，单线程解析速度超 50,000 symbols/s，结合 Rayon 并行化实现万级文件 30 秒内全量索引。
- 设计增量更新机制，基于 *XXH3-128* 内容哈希检测变更，配合 notify 文件监听实现 1 秒内变更感知，单文件增量更新延迟低于 500ms。
- 采用 *OpenSpec* 规范驱动开发，为 10 个核心模块编写机器可读的行为契约与性能指标，作为 MCP Server 集成至 Claude Code 等 AI 开发工具。

// ===== 荣誉证书 =====

#section-title(emoji.medal.sports, [荣誉证书])

- 沈阳工业大学创新创业奖学金 & 创新创业先进个人
- 2024年腾讯犀牛鸟开源人才培养计划 3TS课题优秀学生
