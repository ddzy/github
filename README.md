# github

## 项目介绍

flutter仿移动端Github App，主要实现：

* [X] 首页
* [X] 登录页
* [X] 个人资料页
* [X] repo仓库页
* [X] repo仓库详情页
* [X] repo代码详情页
* [X] issue议题页
* [X] issue议题详情页
* [X] starred已加星标页

项目主要使用 `github`官方提供的 `GraphQL API`，文档地址：

> https://docs.github.com/zh/graphql

## 运行和调试

### vscode

以mac为例，需要先配置iOS模拟器：

```bash
open -a Simulator
```

然后安装好 `vscode`所需的 `flutter`插件；

接着在 `vscode`中按 `F5`即可以调试的方式启动项目（可通过引入 `dart:developer`包提供的 `log()`方法在终端调试控制台打印数据)

项目使用 `json_serializable`简化json对象和dart对象的互相转换流程，在 `vscode`终端中可以通过如下命令自动化生成 `*.g.dart`文件：

```dart
dart run build_runner watch
```
