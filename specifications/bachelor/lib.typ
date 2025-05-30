#import "../../specifications/bachelor/cover.typ": cover
#import "../../specifications/bachelor/abstract.typ": abstract, abstract-page
#import "../../specifications/bachelor/abstract-en.typ": abstract-en, abstract-en-page
#import "../../specifications/bachelor/appendix.typ": appendix, appendix-part
#import "../../specifications/bachelor/acknowledgement.typ": acknowledgement, acknowledgement-page
#import "../../utils/custom-numbering.typ": custom-numbering
#import "../../utils/custom-cuti.typ": *
#import "../../utils/bilingual-bibliography.typ": bilingual-bibliography
#import "../../utils/custom-heading.typ": active-heading, heading-display, current-heading
#import "../../utils/style.typ": 字号, 字体

#import "@preview/numbly:0.1.0": numbly
#import "@preview/numblex:0.1.1": circle_numbers
#import "@preview/i-figured:0.2.4"

// 广州大学普通本科生毕业生毕业论文（设计）规范化要求
// 参考规范: http://jwc.gzhu.edu.cn/__local/2/56/92/93F8B5CA22C0F5CF188CAE1F75D_841835B3_316E2.pdf?e=.pdf
#let doc(
  // 毕业论文基本信息
  thesis-info: (
    // 论文标题，将展示在封面、扉页与页眉上
    // 多行标题请使用数组传入 `("thesis title", "with part next line")`，或使用换行符：`"thesis title\nwith part next line"`
    title: "广州大学普通本科生毕业生毕业论文（设计）规范化要求 (2017-)",
    title-en: "The Specification of Writting and Printing for GZHU thesis",

    // 论文作者信息：学号、姓名、院系、专业、指导老师
    author: (
      sno: "1xxxxxxx",
      name: "张三",
      class: "某班级",
      department: "某学院",
      major: "某专业",
    ),

    // 指导老师信息，以`("name", "title")` 数组方式传入
    supervisor: ("李四",),

    // 提交日期，默认为论文 PDF 生成日期
    submit-date: datetime.today(),
  ),

  // 参考文献来源
  bibliography: none,

  // 控制页面是否渲染
  pages: (
    // 封面可能由学院统一打印提供，因此可以不渲染
    cover: true,

    // 附录部分为可选。设置为 true 后，会在参考文献部分与致谢部分之间插入附录部分。
    appendix: false,
  ),

  // 论文内文各大部分的标题用“一、二…… （或1、2……）”， 次级标题为“（一）、（二）……（或
  // 1.1、2.1……）”，三级标题用“1、2……（或1.1.1、2.1.1……）”，四级标题用“（1）、（2）……
  //（或1.1.1.1、2.1.1.1……）”，不再使用五级以下标题。两类标题不要混编。
  numbering_main: custom-numbering.with(first-level: "第一章 ", depth: 4, "1.1 "),

  // 双面模式，会加入空白页，便于打印
  twoside: false,

  // 论文正文信息，包括绪论、主体、结论
  content
) = {
  // 论文信息参数处理。要求必须传递，且符合规格的参数
  assert(type(thesis-info) == dictionary)
  assert(type(thesis-info.title) == array or type(thesis-info.title) == str)
  assert(type(thesis-info.title-en) == array
    or type(thesis-info.title-en) == str
  )
  // 论文信息默认参数。函数传入参数会完全覆盖参数值，因此需要提供默认参数补充。
  // 彩蛋：如果论文参数不传递作者参数，那么论文就会被署名论文模板作者
  let default-author = (
    sno: "13xxxx87",
    name: "Sunny Huang",
    grade: "2013",
    department: "数据科学与计算机学院",
    major: "软件工程",
  )
  thesis-info.author = thesis-info.at("author", default: default-author)

  let default-thesis-info = (
    title: "广州大学普通本科生毕业生毕业论文（设计）规范化要求",
    title-en: "The Specification of Writting and Printing for GZHU thesis",
    supervisor: ("李四",),
    submit-date: datetime.today(),
  )
  thesis-info = default-thesis-info + thesis-info

  // 论文渲染控制参数处理。设置可选页面的默认设置项
  let default-pages = (
    cover: true,
    appendix: false,
  )
  pages = default-pages + pages

  set document(
    title: thesis-info.title,
    author: thesis-info.author.name,
    // keywords: thesis-info.abstract.keywords,
  )

  // 纸张大小：A4。页边距：上边距20 mm，下边距20 mm，左边距均为27 mm，右边距25 mm。
  set page(paper: "a4", margin: (left: 2.7cm, right: 2.5cm, top: 2cm, bottom: 2cm))

  // 行距：固定为 23pt
  // 因此设置为 23pt - 0.75em
  // [line-height 模型]: https://github.com/typst/typst/issues/4224
  set par(leading: 23pt - 0.75em)

  // 目录内容 宋体小四号
  // 正文内容 宋体小四号
  // 致谢、附录内容	宋体小四号
  set text(lang: "zh", font: 字体.宋体, size: 字号.小四)

  // 论文内文各大部分的标题用“一、二…… （或1、2……）”， 次级标题为“（一）、（二）……（或
  // 1.1、2.1……）”，三级标题用“1、2……（或1.1.1、2.1.1……）”，四级标题用“（1）、（2）……
  //（或1.1.1.1、2.1.1.1……）”，不再使用五级以下标题。两类标题不要混编。
  set heading(numbering: numbering_main)

  // 标题黑体加粗
  show: show-cn-fakebold
  show heading: set text(weight: "bold")

  // 章标题前空 0.5 行，后空 1 行
  // 节标题段前空 1 行，后各空 0.5 行
  // 行理解为当前行距，1 行为 "1.5倍行距"。
  show heading.where(level: 1): set block(above: 1em * 120% * 1.5, below: 1em * 120% * 1.5 * 1.5)
  show heading.where(level: 2): set block(above: 1em * 120% * 1.5, below: 23pt - 0.5em)
  show heading.where(level: 3): set block(above: 1em * 120% * 1.5, below: 23pt - 0.5em)
  show heading.where(level: 4): set block(above: 1em * 120% * 1.5, below: 23pt - 0.5em)

  // 目录标题 黑体三号居中
  // 正文各章标题 黑体三号居中
  // 参考文献标题 黑体三号居中
  // 致谢、附录标题	黑体三号居中
  show heading.where(level: 1): set text(font: 字体.黑体, size: 字号.三号)
  show heading.where(level: 1): set align(center)

  // 正文各节一级标题以下 黑体小四号左对齐
  show heading.where(level: 2): set text(font: 字体.黑体, size: 字号.小四)
  show heading.where(level: 3): set text(font: 字体.黑体, size: 字号.小四)
  show heading.where(level: 4): set text(font: 字体.黑体, size: 字号.小四)

  // 遇到一级标题重置图、表、公式编号计数
  show heading: i-figured.reset-counters
  show figure: i-figured.show-figure
  show math.equation: i-figured.show-equation.with(
    numbering: (..n) => text(
      font: 字体.宋体,
      numbering("(1.1)",..n)
    )
  )

  // 代码使用 Times New Roman 字体
  show raw: set text(font: 字体.宋体, size: 字号.小四)

  // 引文序号字体使用 TeX Gyre Termes
  show cite: set text(font: "TeX Gyre Termes")
  
  // 图题、表题 宋体五号
  show figure.caption: set text(font: 字体.宋体, size: 字号.五号)

  // 标题放置在表格上方
  show figure.where(kind: table): set figure.caption(position: top)

  // 脚注、尾注 宋体小五号
  show footnote.entry: set text(font: 字体.宋体, size: 字号.小五)

  // 注释：毕业论文（设计）中有个别名词或情况需要解释时，可加注说明。注释采用脚注或尾注，
  // 应根据注释的先后顺序编排序号。注释序号以“①、②”等数字形式标示在正文中被注释词条的
  // 右上角，脚注或尾注内容中的序号应与被注释词条序号保持一致。
  show footnote: set footnote(numbering: circle_numbers)

  // 毕业论文应按以下顺序装订和存档：
  // 封面->扉页->学术诚信声明->摘要->目录->正文->参考文献（->附录）->致谢。
  if pages.cover {
    cover(info: thesis-info)
    pagebreak(weak: true, to: if twoside { "odd" })
  }
  
  abstract-page(info: thesis-info)
  pagebreak(weak: true, to: if twoside { "odd" })
  abstract-en-page()
  pagebreak(weak: true, to: if twoside { "odd" })

  // 目录使用罗马数字标号
  set page(numbering: "I")
  counter(page).update(1)

  // 目录最深为三级标题
  outline(
    indent: 2em,
    depth: 3
  )
  pagebreak(weak: true, to: if twoside { "odd" })

  // 绪论开始至论文结尾，以阿拉伯数字（1，2，3…）编连续码
  set page(numbering: "1")
  counter(page).update(1)

  // 正文段落按照中文惯例缩进两格
  set par(first-line-indent: (amount: 2em, all: true), justify: true)

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    it
  }

  content
  pagebreak(weak: true, to: if twoside { "odd" })

  // 参考文献
  {
    // 参考文献内容 宋体五号
    set text(font: 字体.宋体, size: 字号.小四)
    bilingual-bibliography(bibliography: bibliography, full: false)
  }
  pagebreak(weak: true, to: if twoside { "odd" })

  // 附录
  if pages.appendix {
    appendix-part()
    pagebreak(weak: true, to: if twoside { "odd" })
  }

  // 致谢
  acknowledgement-page()
  pagebreak(weak: true, to: if twoside { "odd" })
}

// 以下为校对用测试 preview 页面
#show: doc.with(
  bibliography: bibliography.with("../../template/ref.bib"),
  pages: (
    appendix: true
  )
)


// 正文各部分的标题应简明扼要，不使用标点符号。
= 第某章 <chapter1>
== 节标题
=== 小节标题
==== 四级标题
写一下测试的内容 @chapter1-img，章节标题 @chapter1[("第一章")]

#figure(
  image("../../assets/vi/gzhu.png", width: 20%),
  caption: [图片测试],
) <chapter1-img>

// #show: appendix
= 第一章 <appendix>
== 节标题
=== 小节标题
==== 四级标题
在附录中引用图片 @appendix-img, 以及附录章节标题 @appendix[#numbering("附录A")]

#figure(
  image("../../assets/vi/gzhu.png", width: 20%),
  caption: [图片测试],
) <appendix-img>
