//
//  FFComposeView.m
//  FFEmptyViewExample
//
//  Created by North on 2021/4/28.
//

#import "FFComposeView.h"

@interface FFComposeView ()

@property (assign, nonatomic) CGSize imageSize;
@property (assign, nonatomic) CGSize textSize;
@property (assign, nonatomic) BOOL isTouching;
@property (retain, nonatomic) NSAttributedString * attrString;


@end


@implementation FFComposeView

- (CGSize)autoAdaptionSize{
    
    if ([self.compose isEmpty]) return CGSizeZero;
    
    if (self.compose.imageFixedSize.width > 0 && self.compose.imageFixedSize.height > 0 && self.compose.image) {
        self.imageSize = self.compose.imageFixedSize;
    } else if (self.compose.image) {
        self.imageSize = self.compose.image.size;
    } else {
        self.imageSize = CGSizeZero;
    }
    
    
    if (self.compose.attributed) {

        self.attrString = self.compose.attributed;
    }
    
    else if (self.compose.text){
        
        NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc]initWithString:self.compose.text];
        NSMutableParagraphStyle * paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.alignment = NSTextAlignmentCenter;
        
        NSMutableDictionary * attributes = @{}.mutableCopy;
        [attributes setValue:paragraph forKey:NSParagraphStyleAttributeName];
        [attributes setValue:self.compose.font forKey:NSFontAttributeName];
        [attributes setValue:self.compose.color forKey:NSForegroundColorAttributeName];
        
        [attrString setAttributes:attributes range:NSMakeRange(0, self.compose.text.length)];
        self.attrString  = attrString;
        
    }
    
    if (self.attrString) {
        
        CGFloat maxWdith = self.compose.maxWidth - self.compose.contentInset.left - self.compose.contentInset.right;
        
        if (self.imageSize.width > 0 && (self.compose.composeType == FFComposeTypeImageLeft  || self.compose.composeType == FFComposeTypeImageRight)) {
            
            maxWdith -= self.imageSize.width - self.compose.speacing;
        }
        
        self.textSize = [self.attrString boundingRectWithSize:CGSizeMake(maxWdith, HUGE) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size;
    } else {
        
        self.textSize = CGSizeZero;
    }
    
    //计算宽高
    
    CGFloat width = 0;
    CGFloat height = 0;
    
    //图片在左/右
    if (self.compose.composeType == FFComposeTypeImageLeft || self.compose.composeType == FFComposeTypeImageRight) {
        
        width = self.textSize.width + self.imageSize.width;
        height = MAX(self.textSize.height, self.imageSize.height);
        
        if (self.imageSize.width > 0 && self.textSize.width > 0) {
            width += self.compose.speacing;
        }
        
    } else {
        
        width = MAX(self.textSize.width, self.imageSize.width);
        height = self.textSize.height + self.imageSize.height;
        
        if (self.imageSize.height > 0 && self.textSize.height > 0) {
            height += self.compose.speacing;
        }
    }
    
    CGSize size = CGSizeMake(width, height);
    
    if (size.width > 0 && size.height > 0){
        size.width += self.compose.contentInset.left + self.compose.contentInset.right;
        size.height += self.compose.contentInset.top + self.compose.contentInset.bottom;
    }
    
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
    return size;
    
}


- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    UIEdgeInsets inset = self.compose.contentInset;
    CGFloat speacing = self.compose.speacing;
    
    
    if (self.compose.fillColor) {
        UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.compose.radius];
        
        UIColor * fillColor = self.isTouching ? [self.compose.fillColor colorWithAlphaComponent:.6] : self.compose.fillColor;
        
        [fillColor setFill];
        [path fill];
    }
    
    
    if (self.compose.boderColor && self.compose.boderWidth > 0) {
        
        CGRect rect = self.bounds;
        rect.size.height -= self.compose.boderWidth;
        rect.size.width -= self.compose.boderWidth;
        rect.origin.x = self.compose.boderWidth/2.0;
        rect.origin.y = self.compose.boderWidth/2.0;
        
        UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.compose.radius];
        path.lineWidth = self.compose.boderWidth;
        
        UIColor * boderColor = self.isTouching ? [self.compose.boderColor colorWithAlphaComponent:.6] : self.compose.boderColor;
        
        [boderColor setStroke];
        [path stroke];
    }
    
    
    
    // 如果图片在上
    if (self.compose.composeType == FFComposeTypeImageTop) {
        
        CGFloat contentHeight = 0;
        if (self.imageSize.width > 0) contentHeight += self.imageSize.height;
        if (self.textSize.width > 0) contentHeight += self.textSize.height;
        if (self.imageSize.width > 0 && self.textSize.width > 0) contentHeight += speacing;
        
        CGFloat top = ( height - inset.top - inset.bottom - contentHeight ) / 2.0 + inset.top;
        
        if (self.imageSize.width > 0) {
            CGRect imageFrame = CGRectMake((width - inset.left - inset.right - self.imageSize.width)/2.0 + inset.left, top, self.imageSize.width,  self.imageSize.height);
            
            [self.compose.image drawInRect:imageFrame];
            
            top += self.imageSize.height;
            
            if (self.textSize.width > 0) top += speacing;
        }
        
        if (self.textSize.width > 0) {
            
            CGRect textFrame = CGRectMake((width - inset.left - inset.right - self.textSize.width) / 2.0  + inset.left, top, self.textSize.width , self.textSize.height);
            [self.attrString drawInRect:textFrame];
            
        }
    }
    
    // 如果图片在左
    if (self.compose.composeType == FFComposeTypeImageLeft) {
        
        CGFloat contentWidth = 0;
        
        if (self.imageSize.width > 0) contentWidth += self.imageSize.width;
        if (self.imageSize.width > 0 && self.textSize.width > 0) contentWidth += speacing;
        if (self.textSize.width > 0) contentWidth += self.textSize.width;
        
        
        CGFloat left = ( width - inset.left - inset.right - contentWidth ) / 2.0 + inset.left;
        
        if (self.imageSize.width > 0) {
            CGRect imageFrame = CGRectMake(left, (height - inset.top - inset.bottom -  self.imageSize.height)/2.0 +  inset.top, self.imageSize.width,  self.imageSize.height);
            [self.compose.image drawInRect:imageFrame];
            left += self.imageSize.width;
            
            if (self.textSize.width > 0) left += speacing;
        }
        
        if (self.textSize.width > 0) {
            
            CGRect textFrame = CGRectMake(left, (height - inset.top - inset.bottom - self.textSize.height)/2.0 +  inset.top, self.textSize.width, self.textSize.height);
            [self.attrString drawInRect:textFrame];
            
        }
    }
    
    // 如果图片在下
    if (self.compose.composeType == FFComposeTypeImageBottom) {
        
        CGFloat contentHeight = 0;
        if (self.imageSize.width > 0) contentHeight +=  self.imageSize.height;
        if (self.textSize.width > 0) contentHeight += self.textSize.height;
        if (self.imageSize.width > 0 && self.textSize.width > 0) contentHeight += speacing;
        
        CGFloat top = ( height - inset.top - inset.bottom - contentHeight ) / 2.0 + inset.top;
        
        
        if (self.textSize.width > 0) {
            
            CGRect textFrame = CGRectMake((width - inset.left - inset.right - self.textSize.width)/2.0 + inset.left, top, self.textSize.width, self.textSize.height);
            [self.attrString drawInRect:textFrame];
            
            top += self.textSize.height;
            
            if (self.imageSize.width > 0) top += speacing;
        }
        
        if (self.imageSize.width > 0) {
            CGRect imageFrame = CGRectMake((width - inset.left - inset.right - self.imageSize.width)/2.0 + inset.left, top, self.imageSize.width,  self.imageSize.height);
            [self.compose.image drawInRect:imageFrame];
            
        }
        
        
    }
    
    
    // 如果图片在右
    if (self.compose.composeType == FFComposeTypeImageRight) {
        
        CGFloat contentWidth = 0;
        
        if (self.imageSize.width > 0) contentWidth += self.imageSize.width;
        if (self.imageSize.width > 0 && self.textSize.width > 0) contentWidth += speacing;
        
        
        if (self.textSize.width > 0) contentWidth += self.textSize.width;
        
        CGFloat left = ( width - inset.left - inset.right - contentWidth ) / 2.0 + inset.left;
        
        
        if (self.textSize.width > 0) {
            
            CGRect textFrame = CGRectMake(left, (height - inset.top - inset.bottom - self.textSize.height)/2.0 +  inset.top, self.textSize.width, self.textSize.height);
            [self.attrString drawInRect:textFrame];
            
            left += self.textSize.width;
            
            if (self.imageSize.width > 0) left += speacing;
        }
        
        if (self.imageSize.width > 0) {
            CGRect imageFrame = CGRectMake(left, (height - inset.top - inset.bottom -  self.imageSize.height)/2.0 + inset.top, self.imageSize.width,  self.imageSize.height);
            [self.compose.image drawInRect:imageFrame];
        }
        
        
    }

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (!self.compose.touchBlock) return;
    
    self.isTouching = YES;
    [self setNeedsDisplay];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (!self.compose.touchBlock) return;
    if (self.compose.touchBlock)self.compose.touchBlock();
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.isTouching = NO;
        [self setNeedsDisplay];
    });
}


@end

@implementation FFCompose

- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        self.contentInset = UIEdgeInsetsZero;
        self.font = [UIFont systemFontOfSize:15];
        self.color = [UIColor lightGrayColor];
    }
    
    return self;
}

- (BOOL)isEmpty{
    
    return !self.attributed && !self.text && !self.text;
}

@end
