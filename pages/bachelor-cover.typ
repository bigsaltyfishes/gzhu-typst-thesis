#import "../utils/datetime-display.typ": datetime-display
#import "../utils/style.typ": 字号, 字体, sysucolor

// 本科生封面
#let bachelor-cover(
  // documentclass 传入的参数
  anonymous: false,
  twoside: false,
  fonts: (:),
  info: (:),
  // 其他参数
  stoke-width: 0.5pt,
  min-title-lines: 2,
  info-inset: (x: 0pt, bottom: 1pt),
  info-key-width: 72pt,
  info-key-font: "楷体",
  info-value-font: "楷体",
  column-gutter: -3pt,
  row-gutter: 11.5pt,
  anonymous-info-keys: ("grade", "student-id", "author", "supervisor", "supervisor-ii"),
  bold-info-keys: ("title",),
  bold-level: "bold",
  datetime-display: datetime-display,
) = {
  // 1.  默认参数
  fonts = 字体 + fonts
  info = (
    title: ("基于 Typst 的", "南京大学学位论文"),
    grade: "20XX",
    student-id: "1234567890",
    author: "张三",
    department: "某学院",
    major: "某专业",
    supervisor: ("李四", "教授"),
    submit-date: datetime.today(),
  ) + info

  // 2.  对参数进行处理
  // 2.1 如果是字符串，则使用换行符将标题分隔为列表
  if type(info.title) == str {
    info.title = info.title.split("\n")
  }
  // 2.2 根据 min-title-lines 填充标题
  info.title = info.title + range(min-title-lines - info.title.len()).map((it) => "　")
  // 2.3 处理提交日期
  if type(info.submit-date) == datetime {
    info.submit-date = datetime-display(info.submit-date)
  }

  // 3.  内置辅助函数
  let info-key(body) = {
    rect(
      width: 100%,
      inset: info-inset,
      stroke: none,
      text(
        font: fonts.at(info-key-font, default: "楷体"),
        size: 字号.三号,
        body
      ),
    )
  }

  let info-value(key, body) = {
    set align(center)
    rect(
      width: 100%,
      inset: info-inset,
      stroke: (bottom: stoke-width + black),
      text(
        font: fonts.at(info-value-font, default: "宋体"),
        size: 字号.三号,
        weight: if (key in bold-info-keys) { bold-level } else { "regular" },
        bottom-edge: "descender",
        body,
      ),
    )
  }

  let info-long-value(key, body) = {
    grid.cell(colspan: 3,
      info-value(
        key,
        if anonymous and (key in anonymous-info-keys) {
          "██████████"
        } else {
          body
        }
      )
    )
  }

  let info-short-value(key, body) = {
    info-value(
      key,
      if anonymous and (key in anonymous-info-keys) {
        "█████"
      } else {
        body
      }
    )
  }


  // 4.  正式渲染

  pagebreak(weak: true, to: if twoside { "odd" })

  // 居中对齐
  set align(center)

  // 封面校徽
  // 使用校方官方 VI 系统的 logo，来源：https://home3.sysu.edu.cn/sysuvi/index.html
  image("../assets/vi/sysu_logo.svg", width: 3cm)

  text(size: 字号.小初, font: 字体.宋体, weight: "bold", fill: sysucolor.green)[本科生毕业论文（设计）]
  v(-2em)
  line(length: 200%, stroke: 0.12cm + sysucolor.green);
  v(-0.8em)
  line(length: 200%, stroke: 0.05cm + sysucolor.green);
  v(1.5cm)

  if anonymous {
    v(155pt)
  } else {
    v(67pt)
  }

  block(width: 318pt, grid(
    columns: (info-key-width, 1fr, info-key-width, 1fr),
    column-gutter: column-gutter,
    row-gutter: row-gutter,
    info-key("院　　系"),
    info-long-value("department", info.department),
    info-key("专　　业"),
    info-long-value("major", info.major),
    info-key("题　　目"),
    ..info.title.map((s) => info-long-value("title", s)).intersperse(info-key("　")),
    info-key("年　　级"),
    info-short-value("grade", info.grade),
    info-key("学　　号"),
    info-short-value("student-id", info.student-id),
    info-key("学生姓名"),
    info-long-value("author", info.author),
    info-key("指导教师"),
    info-short-value("supervisor", info.supervisor.at(0)),
    info-key("职　　称"),
    info-short-value("supervisor", info.supervisor.at(1)),
    ..(if info.supervisor-ii != () {(
      info-key("第二导师"),
      info-short-value("supervisor-ii", info.supervisor-ii.at(0)),
      info-key("职　　称"),
      info-short-value("supervisor-ii", info.supervisor-ii.at(1)),
    )} else {()}),
    info-key("提交日期"),
    info-long-value("submit-date", info.submit-date),
  ))
}