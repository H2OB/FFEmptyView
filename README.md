# FFEmptyView

空视图由`上方式图`、`中间视图`、`下房视图`三部分构成，而这三个视图类型都是同一个`FFComposeView`。  


而`FFComposeView`是一个由`image`和`text`组成的视图，可以调整`image`和`text`的间距，`image`相对`text`的位置(详见`FFComposeType`)，以及`边框`，`圆角`，和代替背景色的填充色`fillColor` ,并且可以响应点击事件 。`image`和`text`都可以只存在一个，当只有`image`或`text`的时候默认居中显示。
```

typedef NS_OPTIONS(NSUInteger, FFComposeType) {

FFComposeTypeImageTop           = 0, //图片在上
FFComposeTypeImageLeft          = 1, //图片在左
FFComposeTypeImageBottom        = 2, //图片在下
FFComposeTypeImageRight         = 3  //图片在右
}
```
```
/// 组合类型 即图片相对文本的位置
@property (assign, nonatomic) FFComposeType composeType;

#pragma mark - 尺寸
/// 最大宽度
@property (assign, nonatomic) CGFloat maxWidth;

/// 内边距 默认UIEdgeInsetsZero
@property (assign, nonatomic) UIEdgeInsets  contentInset;

/// 间距
@property (assign, nonatomic) CGFloat  speacing;

#pragma mark - 图片

/// 图片
@property (retain, nonatomic) UIImage * image;

/// 固定图片大小默认 CGSizeZero 如果不想图片原始大小显示可在这里设置大小
@property (assign, nonatomic) CGSize imageFixedSize;

#pragma mark - 文字

/// 内容
@property (copy, nonatomic) NSString * text;

/// 字体 默认16
@property (retain, nonatomic) UIFont * font;

/// 颜色 默认blackColor
@property (retain, nonatomic) UIColor * color;

/// 富文本
@property (retain, nonatomic) NSAttributedString * attributed;

#pragma mark - 边框

/// 边框宽度
@property (assign, nonatomic) CGFloat  boderWidth;

/// 边框颜色
@property (retain, nonatomic) UIColor * boderColor;

/// 圆角
@property (assign, nonatomic) CGFloat radius;


#pragma mark - 背景
/// 填充颜色
@property (retain, nonatomic) UIColor * fillColor;


#pragma mark - 点击
/// 点击回调 如果需要请调用
@property (copy, nonatomic) void(^touchBlock)(void);
```

至此，我们就可以设置我们想要显示的空视图了

# 使用
如果指向显示一个图片和一段文字(或者只有图片文字中的一个)
```
self.view.emptyView.topCompose.image = [UIImage imageNamed:@"beianbgs"];
self.view.emptyView.topCompose.text = @"NO Message";
self.view.emptyView.topCompose.composeType = FFComposeTypeImageLeft;
self.view.emptyView.topCompose.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
self.view.emptyView.topCompose.speacing = 6;
```
也可以简写为
```
self.view.compose.image = [UIImage imageNamed:@"beianbgs"];
self.view.compose.text = @"NO Message";
self.view.compose.composeType = FFComposeTypeImageTop;
self.view.compose.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
self.view.compose.speacing = 6;
```
原理是
```
- (FFCompose *)compose {
return self.emptyView.topCompose;
}
```

而中间和下方设置相同如果你想把它变成一个按钮那么你需要设置它的
```
/// 边框宽度
@property (assign, nonatomic) CGFloat  boderWidth;

/// 边框颜色
@property (retain, nonatomic) UIColor * boderColor;

/// 圆角
@property (assign, nonatomic) CGFloat radius;


#pragma mark - 背景
/// 填充颜色 用于代替背景色
@property (retain, nonatomic) UIColor * fillColor;


#pragma mark - 点击
/// 点击回调 如果需要请调用
@property (copy, nonatomic) void(^touchBlock)(void);

```

# 最后
`UITableView` 和 `UICollectionView` 会根据数据自动显示隐藏，且首次在网络请求不会显示，其他view不支持自动显示隐藏。