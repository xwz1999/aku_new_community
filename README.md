# aku_community

## Getting Started

## Code Contribute

### After pull this repo

#### 资源文件生成器

```shell
flutter pub run flutter_asset_generator:resource_generator
```

```shell
fgen
```

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
