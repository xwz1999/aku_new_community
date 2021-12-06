# aku_new_community

## Getting Started

## Code Contribute

### After pull this repo

## 使用以下命令生成运行所必需文件

###生成图片路径(fgen)
使用以下代码全局启用构建器
```shell
 flutter pub global activate global activate flutter_asset_generator
```
或使用
```shell
flutter pub run flutter_asset_generator:resource_generator

```
###生成model.g.dart
```shell
flutter pub run build_runner build
```
## 启用脚本命令(grind)
使用以下代码全局启用构建器
```shell
flutter pub global activate grinder
```
或使用
```shell
flutter pub run grinder
```
命令列表见```/tool/grind.dart```
### Before git push

#### import 排序

```shell
flutter pub run import_sorter:main
grind sort
```

#### format code

```shell
flutter format
grind format
```
### 打包(自动命名安装包仅安卓有效)
```shell
grind build-apk-dev//测试环境
grind build-apk //正式环境
grind build-ios //打包ios--Xcode打开--archive
```
### json序列化
```shell
grind gen
grind gen-clean//生成新model

## Widget Guide Book

### 选择器

* BeeDatePicker - 时间选择器
* BeeImagePicker - 图片选择器
* GridImagePicker - 网格图片选择器
* BeeImagePreview - 图片预览

### 按钮

* BottomButton - 导航栏按钮

### TabBar

* BeeTabBar

### View

* BeeGridImageView - 网格图片显示
* HorizontalImageView - 水平图片显示

p12 password
cyephiathnupinbisosyyatuphuorhs
