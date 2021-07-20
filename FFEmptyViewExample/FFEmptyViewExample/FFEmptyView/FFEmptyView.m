//
//  FFEmptyView.m
//  FFEmptyViewExample
//
//  Created by North on 2021/4/28.
//

#import "FFEmptyView.h"

@interface FFEmptyView ()

@property (retain, nonatomic) FFComposeView * topView;
@property (retain, nonatomic) FFComposeView * middleView;
@property (retain, nonatomic) FFComposeView * bottomView;

@end

@implementation FFEmptyView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setUpView];
    }
    
    return self;
}

- (void)setUpView{
    
    self.backgroundColor = [UIColor redColor];
    
    self.topCompose = [[FFCompose alloc] init];
    self.middleCompose = [[FFCompose alloc] init];
    self.bottomCompose = [[FFCompose alloc] init];
    
    self.topView = [[FFComposeView alloc] initWithFrame:CGRectZero];
    self.topView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.topView];
    
    self.middleView = [[FFComposeView alloc] initWithFrame:CGRectZero];
    self.middleView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.middleView];
    
    self.bottomView = [[FFComposeView alloc] initWithFrame:CGRectZero];
    self.bottomView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bottomView];
    
    
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) {
        
        [self autoAdaptionSize:newSuperview];
        [newSuperview addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew context:nil];
    }

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"bounds"]) {
        
        if (self.superview) {
            [self autoAdaptionSize:self.superview];
        }
    
    }
    
}

- (void)removeFromSuperview{
    
    [self.superview removeObserver:self forKeyPath:@"bounds"];
    [super removeFromSuperview];
}


- (void)autoAdaptionSize:(UIView *)view{
    
    CGFloat maxWidth = CGRectGetWidth(view.bounds);
    CGFloat maxHeight = CGRectGetHeight(view.bounds);
    
    self.topCompose.maxWidth = self.topCompose.maxWidth > 0 ? self.topCompose.maxWidth : maxWidth;
    self.middleCompose.maxWidth = self.middleCompose.maxWidth > 0 ? self.middleCompose.maxWidth : maxWidth;
    self.bottomCompose.maxWidth = self.bottomCompose.maxWidth > 0 ? self.bottomCompose.maxWidth : maxWidth;
    
    self.topView.compose = self.topCompose;
    CGSize topSize = [self.topView autoAdaptionSize];
    
    self.middleView.compose = self.middleCompose;
    CGSize middlesize = [self.middleView autoAdaptionSize];
    
    self.bottomView.compose = self.bottomCompose;
    CGSize bottomSize = [self.bottomView autoAdaptionSize];
    
    
    CGFloat totalWidth = MAX(topSize.width, MAX(middlesize.width, bottomSize.width));
    CGFloat top = 0;
    
    if (![self.topCompose isEmpty]) {
        
        self.topView.frame = CGRectMake((totalWidth - topSize.width)/2.0, top, topSize.width, topSize.height);
        top += topSize.height;
        
        if (![self.middleCompose isEmpty] || ![self.bottomCompose isEmpty]) {
            top += self.topMiddleSpeacing;
        }
        
    }
    
    if (![self.middleCompose isEmpty]) {
        
        self.middleView.frame = CGRectMake((totalWidth - middlesize.width)/2.0, top, middlesize.width, middlesize.height);
        top += middlesize.height;
        
        if (![self.bottomCompose isEmpty]) {
            top += self.middleBottomSpeacing;
        }
    }
    
    if (![self.bottomCompose isEmpty]) {
        
        self.bottomView.frame = CGRectMake((totalWidth - bottomSize.width)/2.0, top, bottomSize.width, bottomSize.height);
        
        top += bottomSize.height;
    }
    
    
    CGRect frame = self.frame;
    frame.size.width = totalWidth;
    frame.size.height = top;
    
    self.frame = frame;
    
    CGPoint center = CGPointMake(maxWidth/2.0, maxHeight/2.0);
    center.x += self.centerOffsets.x;
    center.y += self.centerOffsets.y;
    
    self.center = center;
   

}


- (BOOL)isEmpty{
    
    return [self.topCompose isEmpty] && [self.middleCompose isEmpty] && [self.bottomCompose isEmpty];
}

@end
