//
//  FFEmptyView.h
//  FFEmptyViewExample
//
//  Created by North on 2021/4/28.
//

#import <UIKit/UIKit.h>
#import "FFComposeView.h"

@interface FFEmptyView : UIView

/// 上方组合
@property (retain, nonatomic) FFCompose * topCompose;

/// 中间组合
@property (retain, nonatomic) FFCompose * middleCompose;

/// 底部组合
@property (retain, nonatomic) FFCompose * bottomCompose;

/// 顶部和中间的间距
@property (assign, nonatomic) CGFloat topMiddleSpeacing;

/// 中间和底部的间距
@property (assign, nonatomic) CGFloat middleBottomSpeacing;

/// 中心偏移量
@property (assign, nonatomic) CGPoint centerOffsets;


- (BOOL)isEmpty;



@end


