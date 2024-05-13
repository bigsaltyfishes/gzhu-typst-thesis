# 基于 Typst 的中山大学学位论文模板
[![GitLab 仓库](https://img.shields.io/badge/gitlab-%23181717.svg?style=for-the-badge&logo=gitlab&logoColor=white)](https://gitlab.com/sysu-gitlab/thesis-template/better-thesis)
[![GitHub 仓库](https://img.shields.io/badge/gitlab-%23181717.svg?style=for-the-badge&logo=gitlab&logoColor=white)](https://github.com/sysu/better-thesis)

当前还未完全符合学位论文格式要求，欢迎同学们贡献代码！模板交流 QQ 群：797942860（[点此直接加入](https://jq.qq.com/?_wv=1027&k=m58va1kd)）

**Q：我不会 LaTeX，可以用这个模板写论文吗？**

**A：完全可以！Typst 是一个比 LaTeX 更简单的排版语言，同时安装更加方便，编译更加快速！**

## 使用方法

**由于 Typst 还处于初期的快速开发阶段，本项目需要使用从源码编译的 Typst 版本才能正常生成 PDF。仓库提供了一键安装脚本，按照使用说明运行即可。**

<!-- TODO: 提供 typst.universe 版本 -->

### Windows 用户

1. [下载本仓库](https://github.com/howardlau1999/sysu-thesis-typst/archive/refs/heads/master.zip)，或者使用 `git clone https://github.com/howardlau1999/sysu-thesis-typst` 命令克隆本仓库。
2. 右键 `install_typst.ps1` 文件，选择“用 Powershell 运行”，等待 Typst 安装完成。
3. 根据 [Typst 文档](https://typst.app/docs/)，参考 [项目结构](#项目结构) 中的说明，按照你的需要修改论文的各个部分。
4. 双击运行 `compile.bat`，即可生成 `thesis.pdf` 文件。

### Linux/macOS 用户

1. [下载本仓库](https://github.com/howardlau1999/sysu-thesis-typst/archive/refs/heads/master.zip)，或者使用 `git clone https://github.com/howardlau1999/sysu-thesis-typst` 命令克隆本仓库。
2. 使用命令行安装 Rust 工具链以及 Typst：

```bash
# 安装 Rust 环境并激活，之前安装过则不需要执行下面这两行
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

# 安装 Typst CLI
cargo install --git https://github.com/typst/typst.git typst-cli

# 访问缓慢的话，执行以下命令设置清华镜像源，并从镜像站安装
cat << EOF > $HOME/.cargo/config
[source.crates-io]
replace-with = "tuna"

[source.tuna]
registry = "https://mirrors.tuna.tsinghua.edu.cn/git/crates.io-index.git"
EOF
cargo install --git https://ghproxy.com/https://github.com/typst/typst.git
```

3. 根据 [Typst 文档](https://typst.app/docs/)，参考 [项目结构](#项目结构) 中的说明，按照你的需要修改论文的各个部分。
4. 执行 `make` 命令，即可生成 `thesis.pdf` 文件。

## 项目结构

### 主要文件

- `info.typ` 文件中包含论文的基本信息，包括作者、学位、导师、学位论文题目等。
- `custom.typ` 文件中包含论文的自定义设置，包括行距，字体等。
- `thesis.typ` 文件是论文的主体，包含论文的各个章节。在添加或者删除章节文件后，需要同步修改这个文件中的 `#include` 命令。
- `template.typ` 文件是论文的模板，包含论文的各个部分的格式。一般不需要修改。

### 文件夹

- `chapters` 文件夹包含了论文的各个章节文件，你可以自由地增加或删除章节文件，按你自己需要的方式组织文件。在添加或删除文件后，需要同步修改 `thesis.typ` 文件中的 `#include` 命令。
- `templates` 文件夹包含了论文的各个部分的模板文件，你可以自由地增加或删除模板文件，按你自己需要的方式组织文件。在添加或删除文件后，需要同步修改 `template.typ` 文件中的 `#include` 命令。欢迎贡献新的模板文件。
- `functions` 文件夹包含了模板使用到的各种自定义辅助函数，如果你想贡献代码，可以在这个文件夹中添加新的辅助函数。
- `fonts` 文件夹包含了模板使用到的字体文件，你可以按需要添加或者删除字体文件。在添加或删除文件后，可以运行 `typst --font-path fonts fonts` 查看 Typst 检测到的字体文件。
- `bibs` 文件夹包含了论文的参考文献文件，你可以按需要添加或者删除参考文献文件，目录结构没有特殊需求。
- `images` 文件夹包含了论文中使用到的图片文件，你可以按需要添加或者删除图片文件，目录结构没有特殊需求。`vi` 文件夹包含了校徽的矢量图文件。
