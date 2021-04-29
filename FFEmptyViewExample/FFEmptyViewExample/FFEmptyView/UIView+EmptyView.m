//
//  UIView+EmptyView.m
//  MQEmptyViewExample
//
//  Created by North on 2021/4/27.
//

#import "UIView+EmptyView.h"
#import <objc/runtime.h>

@implementation UIView (UIView)

- (FFEmptyView *)emptyView{
    
    FFEmptyView * view = objc_getAssociatedObject(self, _cmd);
    
    if (!view) {
        view = [[FFEmptyView alloc] initWithFrame:CGRectZero];
        view.backgroundColor = [UIColor clearColor];
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return view;
    
}

- (FFCompose *)compose {
    
    return self.emptyView.topCompose;
}
//
//- (void)setComposeType:(NSInteger)composeType{
//    self.compose.composeType = composeType;
//}
//
//- (void)setComposeMaxWidth:(CGFloat)composeMaxWidth{
//    self.compose.maxWidth = composeMaxWidth;
//}
//
//- (void)setComposeContentInset:(UIEdgeInsets)composeContentInset{
//    self.compose.contentInset = composeContentInset;
//}
//
//- (void)setComposeSpeacing:(CGFloat)composeSpeacing{
//    self.compose.speacing = composeSpeacing;
//}
//
//- (void)setComposeImage:(UIImage *)composeImage{
//    self.compose.image = composeImage;
//}
//- (void)setComposeImageFixedSize:(CGSize)composeImageFixedSize{
//    self.compose.imageFixedSize = composeImageFixedSize;
//}
//
//- (void)setComposeText:(NSString *)composeText {
//    self.compose.text = composeText;
//}
//
//- (void)setComposeFont:(UIFont *)composeFont{
//    self.compose.font = composeFont;
//}
//
//- (void)setComposeColor:(UIColor *)composeColor{
//
//    self.compose.color = composeColor;
//}
//
//- (void)setComposeBoderWidth:(CGFloat)composeBoderWidth{
//
//    self.compose.boderWidth = composeBoderWidth;
//}
//
//- (void)setComposeboderColor:(UIColor *)composeboderColor{
//
//    self.compose.boderColor = composeboderColor;
//
//}
//
//- (void)setComposeRadius:(CGFloat)composeRadius{
//    
//    self.compose.radius = composeRadius;
//}
//
//- (void)setComposeFillColor:(UIColor *)composeFillColor{
//
//    self.compose.fillColor = composeFillColor;
//
//}

/// 显示空视图
- (void)showEmptyView{
    
    if ([self.emptyView isEmpty]) return;
    [self addSubview:self.emptyView];
    
}

/// 隐藏空视图
- (void)hideEmptyView{
    
    if ([self.emptyView isEmpty]) return;
    [self.emptyView removeFromSuperview];
    
}


+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
}

- (NSString *)firstLoad{
    return objc_getAssociatedObject(self, _cmd);
}

@end

@implementation UITableView (EmptyView)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(ff_reloadData)];
        
        ///section
        [self exchangeInstanceMethod1:@selector(insertSections:withRowAnimation:) method2:@selector(ff_insertSections:withRowAnimation:)];
        [self exchangeInstanceMethod1:@selector(deleteSections:withRowAnimation:) method2:@selector(ff_deleteSections:withRowAnimation:)];
        [self exchangeInstanceMethod1:@selector(reloadSections:withRowAnimation:) method2:@selector(ff_reloadSections:withRowAnimation:)];
        
        ///row
        [self exchangeInstanceMethod1:@selector(insertRowsAtIndexPaths:withRowAnimation:) method2:@selector(ff_insertRowsAtIndexPaths:withRowAnimation:)];
        [self exchangeInstanceMethod1:@selector(deleteRowsAtIndexPaths:withRowAnimation:) method2:@selector(ff_deleteRowsAtIndexPaths:withRowAnimation:)];
        [self exchangeInstanceMethod1:@selector(reloadRowsAtIndexPaths:withRowAnimation:) method2:@selector(ff_reloadRowsAtIndexPaths:withRowAnimation:)];
        
    });
    
}

- (void)ff_reloadData{
    [self ff_reloadData];
    [self autoShowAndHide];
}

///section
- (void)ff_insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation{
    [self ff_insertSections:sections withRowAnimation:animation];
    [self autoShowAndHide];
}
- (void)ff_deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation{
    [self ff_deleteSections:sections withRowAnimation:animation];
    [self autoShowAndHide];
}
- (void)ff_reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation{
    [self ff_reloadSections:sections withRowAnimation:animation];
    [self autoShowAndHide];
}

///row
- (void)ff_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    [self ff_insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self autoShowAndHide];
}
- (void)ff_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    [self ff_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self autoShowAndHide];
}
- (void)ff_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    [self ff_reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    
    [self autoShowAndHide];
}

- (NSInteger)totalCount{
    
    NSInteger totalCount = 0;
    for (NSInteger section = 0; section < self.numberOfSections; section++) {
        totalCount += [self numberOfRowsInSection:section];
    }
    
    return totalCount;
}


- (void)autoShowAndHide{
    
    if ([self firstLoad] == nil){
        objc_setAssociatedObject(self, @selector(firstLoad), @"firstLoadompletion", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    
    if ([self totalCount] > 0) {
        [self hideEmptyView];
    } else {
        [self showEmptyView];
    }
}


@end

@implementation UICollectionView (EmptyView)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(ff_reloadData)];
        
        ///section
        [self exchangeInstanceMethod1:@selector(insertSections:) method2:@selector(ff_insertSections:)];
        [self exchangeInstanceMethod1:@selector(deleteSections:) method2:@selector(ff_deleteSections:)];
        [self exchangeInstanceMethod1:@selector(reloadSections:) method2:@selector(ff_reloadSections:)];
        
        ///item
        [self exchangeInstanceMethod1:@selector(insertItemsAtIndexPaths:) method2:@selector(ff_insertItemsAtIndexPaths:)];
        [self exchangeInstanceMethod1:@selector(deleteItemsAtIndexPaths:) method2:@selector(ff_deleteItemsAtIndexPaths:)];
        [self exchangeInstanceMethod1:@selector(reloadItemsAtIndexPaths:) method2:@selector(ff_reloadItemsAtIndexPaths:)];
        
    });
    
}

- (void)ff_reloadData{
    [self ff_reloadData];
    
    [self autoShowAndHide];
}
///section
- (void)ff_insertSections:(NSIndexSet *)sections{
    [self ff_insertSections:sections];
    [self autoShowAndHide];
}
- (void)ff_deleteSections:(NSIndexSet *)sections{
    [self ff_deleteSections:sections];
    [self autoShowAndHide];
}
- (void)ff_reloadSections:(NSIndexSet *)sections{
    [self ff_reloadSections:sections];
    [self autoShowAndHide];
}

///item
- (void)ff_insertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    [self ff_insertItemsAtIndexPaths:indexPaths];
    [self autoShowAndHide];
}
- (void)ff_deleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    [self ff_deleteItemsAtIndexPaths:indexPaths];
    [self autoShowAndHide];
}
- (void)ff_reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    [self ff_reloadItemsAtIndexPaths:indexPaths];
    [self autoShowAndHide];
}

- (NSInteger)totalCount{
    
    NSInteger totalCount = 0;
    for (NSInteger section = 0; section < self.numberOfSections; section++) {
        totalCount += [self numberOfItemsInSection:section];
    }
    
    return totalCount;
}



- (void)autoShowAndHide{
    
    if ([self firstLoad] == nil){
        objc_setAssociatedObject(self, @selector(firstLoad), @"firstLoadompletion", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    
    if ([self totalCount] > 0) {
        [self hideEmptyView];
    } else {
        [self showEmptyView];
    }
}

@end
