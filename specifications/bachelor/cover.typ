#import "../../utils/custom-cuti.typ": fakebold
#import "../../utils/datetime-display.typ": datetime-display
#import "../../utils/style.typ": 字号, 字体

// 封面
#let cover(
  info: (:),

  // 其他参数
  stoke-width: 0.5pt,
  min-title-lines: 1,
  info-inset: (x: 0pt, bottom: 1pt),
  info-key-width: 72pt,
  info-key-font: "楷体",
  info-value-font: "楷体",
  column-gutter: -3pt,
  row-gutter: 11.5pt,
  bold-info-keys: (),
  bold-level: "bold",
) = {

  assert(type(info.title) == str)
  assert(type(info.author) == dictionary)

  if type(info.submit-date) == datetime {
    info.submit-date = datetime-display(info.submit-date)
  }

  // 内置辅助函数
  let info-key(
    font: 字体.at(info-key-font, default: "楷体"),
    size: 字号.小二,
    body,
  ) = {
    rect(
      width: 125%,
      inset: info-inset,
      stroke: none,
      {
        text(
          font: font,
          size: size,
          body,
        )
        h(1em)
      },
    )
  }

  let info-value(
    font: 字体.at(info-value-font, default: "楷体"),
    size: 字号.三号,
    key,
    body,
  ) = {
    set align(center)
    rect(
      width: 100%,
      inset: info-inset,
      stroke: (bottom: stoke-width + black),
      text(
        font: font,
        size: size,
        weight: if (key in bold-info-keys) { bold-level } else { "regular" },
        bottom-edge: "descender",
        body,
      ),
    )
  }

  let info-long-value(
    font: 字体.at(info-value-font, default: "楷体"),
    size: 字号.三号,
    key,
    body,
  ) = {
    grid.cell(colspan: 3,
      info-value(
        font: font,
        size: size,
        key,
        body,
      )
    )
  }

  let info-short-value(
    font: 字体.at(info-value-font, default: "楷体"),
    size: 字号.三号,
    key,
    body
  ) = {
    info-value(
      font: font,
      size: size,
      key,
      body,
    )
  }

  // 正式渲染
  // 居中对齐
  set align(center)

  // 封面校徽
  image("../../assets/vi/gzhu.png")
  v(0.15cm)
  
  text(size: 字号.一号, font: 字体.楷体, weight: "bold")[#fakebold[本~~科~~生~~毕~~业~~论~~文（设计）]]
  v(2.5cm)

  // 教务处标记
  place(
    dx: -2em,
    dy: 6.8cm,
    box(
      stack(
        dir: ttb,
        spacing: 16pt,
        {text(font: 字体.楷体, size: 字号.三号, "教")},
        {text(font: 字体.楷体, size: 字号.三号, "务")},
        {text(font: 字体.楷体, size: 字号.三号, "处")},
        {text(font: 字体.楷体, size: 字号.三号, "制")}
      )
    )
  )
  
  // 学生与指导老师信息
  // set align(center + bottom)
  v(76pt)
  block(width: 80%, grid(
    columns: (info-key-width, 1fr, info-key-width, 1fr),
    column-gutter: column-gutter,
    row-gutter: row-gutter,
    info-key("课题名称"),
    info-long-value("title", info.title),
    info-key("学　　院"),
    info-long-value("department", info.author.department),
    info-key("专　　业"),
    info-long-value("major", info.author.major),
    info-key("班级名称"),
    info-long-value("class", info.author.class),
    info-key("学生姓名"),
    info-long-value("author", info.author.name),
    info-key("学　　号"),
    info-long-value("student-id", info.author.sno),
    info-key("指导教师"),
    info-long-value("supervisor", info.supervisor.join(" ")),
    info-key("完成日期"),
    info-long-value("submit-date", info.submit-date),
  ))
  v(2em)
}
