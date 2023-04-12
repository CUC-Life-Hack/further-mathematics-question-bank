# 高数题库

本 repo 为 CUC Life Hack 为高数复习/考试编辑的题库。
题库内容主要来自 CUC 往期的高数考试卷面。

## 如何贡献

题库源码在 `/src/content` 里，均为 TeX 文件。
本项目使用 XeLaTeX 来编译 TeX、以及 Make 来管理复杂操作。

若欲编译单个文件，可以执行：
```bash
$ make build target=[target]
```
其中，`[target]` 是目标 TeX 文件的文件名，不含后缀。

若欲编译所有文件，可以执行：
```bash
$ make all
```

默认显示答案；若需隐藏，在执行前设置变量 `noAnswer=true`。

编译结果在 `/build` 里查看。