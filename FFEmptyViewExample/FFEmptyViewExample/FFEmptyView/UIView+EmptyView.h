//
//  UIView+EmptyView.h
//  MQEmptyViewExample
//
//  Created by North on 2021/4/27.
//

#import <UIKit/UIKit.h>
#import "FFEmptyView.h"
 

@interface UIView (EmptyView)

/// 空视图
@property (retain, nonatomic, readonly) FFEmptyView *emptyView;

///  这个属性等同于 emptyView.topCompose  特用于简单显示
@property (retain, nonatomic, readonly) FFCompose * compose;


#pragma mark - 以下可用于故事版 只适用于给 ↑ compose 设值 防止扰乱所有故事版view故注释
//
///// 组合类型
//@property (assign, nonatomic) IBInspectable NSInteger composeType;
//
///// 最大宽度
//@property (assign, nonatomic) IBInspectable CGFloat composeMaxWidth;
//
///// 内边距 默认UIEdgeInsetsZero
//@property (assign, nonatomic) IBInspectable UIEdgeInsets  composeContentInset;
//
///// 间距
//@property (assign, nonatomic) IBInspectable CGFloat  composeSpeacing;
//
///// 图片
//@property (retain, nonatomic) IBInspectable  UIImage * composeImage;
//
///// 图片固定大小 如果为CGSizeZero 图片大小为原始大小
//@property (assign, nonatomic) IBInspectable CGSize composeImageFixedSize;
//
///// 内容
//@property (copy, nonatomic) IBInspectable NSString * composeText;
//
///// 字体 默认16
//@property (retain, nonatomic) IBInspectable UIFont * composeFont;
//
///// 颜色 默认blackColor
//@property (retain, nonatomic) IBInspectable UIColor * composeColor;
//
///// 边框宽度
//@property (assign, nonatomic) IBInspectable CGFloat  composeBoderWidth;
//
///// 边框颜色
//@property (retain, nonatomic) IBInspectable UIColor * composeboderColor;
//
///// 圆角
//@property (assign, nonatomic) IBInspectable CGFloat composeRadius;
//
///// 填充颜色
//@property (retain, nonatomic) IBInspectable UIColor * composeFillColor;

/// 显示空视图
- (void)showEmptyView;

/// 隐藏空视图
- (void)hideEmptyView;

@end

@interface UITableView (EmptyView)

@end

@interface UICollectionView (EmptyView)

@end
