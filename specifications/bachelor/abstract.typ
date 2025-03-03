#import "../../utils/custom-cuti.typ": fakebold
// 利用 state 捕获摘要参数，并通过 context 传递给渲染函数
#import "../../utils/style.typ": 字号, 字体

#let abstract-keywords = state("keywords", ("广州大学", "论文", "学位论文", "规范"))
#let abstract-content = state("abstract", [
摘要内容论文摘要以浓缩的形式概括研究课题的内容，中文摘要在200字左右。
])
#let abstract(
  keywords: (),
  body,
) = {
  context abstract-keywords.update(keywords)
  context abstract-content.update(body)
}

// 中文摘要页
#let abstract-page(
  info: (:),
) = {
  // 中文摘要内容 宋体小四号
  set text(font: 字体.宋体, size: 字号.小四)

  // 中文摘要标题 黑体三号居中
  show heading.where(level: 1): set text(font: 字体.黑体, size: 字号.三号)

  // 摘要标题不编号
  show heading.where(level: 1): set heading(numbering: none)

  [
    #align(center)[
      #text(font: 字体.黑体, size: 字号.三号, info.title)
      #linebreak()
      #text(info.author.class + " " + info.author.name)
      #linebreak()
      #text("指导教师：" + info.supervisor.join(" "))
    ]

    #v(2em)
    #set par(first-line-indent: 0em, justify: true)
    #text(font: 字体.黑体, size: 字号.四号)[*摘要　*]#context abstract-content.final()

    #v(1em)

    // 摘要正文下方另起一行顶格打印“关键词”款项，后加冒号，多个关键词以逗号分隔。
    // （标题“关键词”加粗，四号黑体）
    #set par(first-line-indent: 0em, justify: true)
    #text(font: 字体.黑体, size: 字号.四号)[*关键词　*]#context abstract-keywords.final().join("，")
  ]
}
