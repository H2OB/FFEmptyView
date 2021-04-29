//
//  FFComposeView.h
//  FFEmptyViewExample
//
//  Created by North on 2021/4/28.
//

#import <UIKit/UIKit.h>
@class FFCompose;
///组合类型
typedef NS_OPTIONS(NSUInteger, FFComposeType) {
    
    FFComposeTypeImageTop           = 0, //图片在上
    FFComposeTypeImageLeft          = 1, //图片在左
    FFComposeTypeImageBottom        = 2, //图片在下
    FFComposeTypeImageRight         = 3  //图片在右
};

/// 图片和文本的组合视图
@interface FFComposeView : UIView

@property (retain, nonatomic) FFCompose * compose;

/// 自适应尺寸
- (CGSize)autoAdaptionSize;


@end

/// 组合节点
@interface FFCompose : NSObject

/// 组合类型
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

/// 图片固定大小 如果为CGSizeZero 图片大小为原始大小
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
/// 点击回调
@property (copy, nonatomic) void(^touchBlock)(void);

- (BOOL)isEmpty;


@end
