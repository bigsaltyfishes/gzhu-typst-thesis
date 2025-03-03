// 利用 state 捕获摘要参数，并通过 context 传递给渲染函数
#import "../../utils/style.typ": 字号, 字体

#let abstract-en-keywords = state("keywords-en", (
  "Guangzhou University",
  "thesis",
  "specification",
))
#let abstract-en-content = state("abstract-en", [
This is abstract in English. 外文摘要以200个左右实词为宜，摘要内容（小四号Times New Roman字体）每段开头留四个空字符
])
#let abstract-en(
  keywords: (),
  body,
) = {
  context abstract-en-keywords.update(keywords)
  context abstract-en-content.update(body)
}

// 英文摘要页
#let abstract-en-page() = {
  // 英文摘要内容 Times New Roman小四号
  set text(font: 字体.宋体, size: 字号.小四)

  // 英文摘要标题	Times New Roman加粗三号全部大写
  show heading.where(level: 1): set text(font: 字体.宋体, size: 字号.三号, weight: "bold")
  
  // 摘要标题不编号
  show heading.where(level: 1): set heading(numbering: none)

  [
    #set par(justify: true)
    #text(size: 字号.四号)[*ABSTRACT　*]#context abstract-en-content.final()

    #v(1em)

    // 摘要正文下方另起一行顶格打印“关键词”款项，后加冒号，多个关键词以逗号分隔。
    // （标题“Keywords”加粗）
    #set par(justify: true)
    #text(size: 字号.四号)[*KEY WORDS　*]#context abstract-en-keywords.final().join(", ")
  ]
}
