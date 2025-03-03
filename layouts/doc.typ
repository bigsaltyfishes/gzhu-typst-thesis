// 文稿设置，可以进行一些像页面边距这类的全局设置
#let doc(
  // documentclass 传入参数
  info: (:),
  // 其他参数
  fallback: false,  // 字体缺失时使用 fallback，不显示豆腐块
  lang: "zh",
  margin: (x: 89pt),
  it,
) = {
  // 1.  默认参数
  info = (
    title: "基于 Typst 的 广州大学学位论文模板",
    author: "张三",
  ) + info

  // 2.  基本的样式设置
  set text(fallback: fallback, lang: lang)
  set page(margin: margin)

  // 3.  PDF 元信息
  set document(
    title: info.title,
    author: info.author,
  )

  it
}
