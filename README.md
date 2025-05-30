# 基于 Typst 的广州大学学位论文模板

## 参考规范
- 广州大学普通本科生毕业生毕业论文（设计）规范化要求 [广州大学普通本科生毕业生毕业论文（设计）规范化要求 2017](http://jwc.gzhu.edu.cn/__local/2/56/92/93F8B5CA22C0F5CF188CAE1F75D_841835B3_316E2.pdf?e=.pdf)
- 教务处下发本科生毕业论文（设计）Word 模板 [广州大学学生毕业论文（设计）模板（中文）](./reference.docx)

## 使用方法

请确认必要的字体都已经安装：
```text
宋体（SimSun）
黑体（SimHei）
楷体（KaiTi_GB2312）
新罗马（Times New Roman）
TeX Gyre Termes
```

### Windows 用户

1. [下载本仓库](https://github.com/bigsaltyfishes/gzhu-typst-thesis/archive/refs/heads/main.zip)，或者使用 `git clone https://github.com/bigsaltyfishes/gzhu-typst-thesis` 命令克隆本仓库。
2. 右键 `install_typst.ps1` 文件，选择“用 Powershell 运行”，等待 Typst 安装完成。
3. 根据 [Typst 文档](https://typst.app/docs/)，参考 [项目结构](#项目结构) 中的说明，按照你的需要修改论文的各个部分。
4. 执行命令 `typst compile main.typ main.pdf` 生成 pdf

### Linux/macOS 用户

1. [下载本仓库](https://github.com/bigsaltyfishes/gzhu-typst-thesis/archive/refs/heads/main.zip)，或者使用 `git clone https://github.com/bigsaltyfishes/gzhu-typst-thesis` 命令克隆本仓库。

2. 使用命令行安装 Rust 工具链以及 Typst：

```bash
# 安装 Rust 环境并激活，之前安装过则不需要执行下面这两行
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

# 安装 Typst CLI
cargo install typst-cli

# 访问缓慢的话，执行以下命令设置清华镜像源，并从镜像站安装
cat << EOF > $HOME/.cargo/config
[source.crates-io]
replace-with = "tuna"

[source.tuna]
registry = "https://mirrors.tuna.tsinghua.edu.cn/git/crates.io-index.git"
EOF
cargo install typst-cli
```

3. 根据 [Typst 文档](https://typst.app/docs/)，参考 [项目结构](#项目结构) 中的说明，按照你的需要修改论文的各个部分。
4. 执行命令 `$HOME/.cargo/bin/typst compile main.typ main.pdf` 生成 pdf

## 项目结构
详见 `template\thesis.typ`

## 致谢
- 感谢 [sysu-thesis-typst] 提供了中山大学的页面样式与初版源码
- 感谢 [modern-nju-thesis] 提供了一个更好的代码组织架构
- 感谢中山大学 Typst 模板交流群（[797942860](https://jq.qq.com/?_wv=1027&k=m58va1kd)）、Typst 中文交流群（793548390）群友的帮助交流。