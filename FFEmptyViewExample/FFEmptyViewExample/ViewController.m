//
//  ViewController.m
//  FFEmptyViewExample
//
//  Created by North on 2021/4/28.
//

#import "ViewController.h"
#import "UIView+EmptyView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.compose.image = [UIImage imageNamed:@"beianbgs"];
    self.view.compose.text = @"NO Message";
    self.view.compose.composeType = FFComposeTypeImageTop;
    self.view.compose.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.view.compose.speacing = 6;
    self.view.compose.fillColor = [UIColor redColor];
    
//    self.view.emptyView.middleCompose.image = [UIImage imageNamed:@"beianbgs"];
//    self.view.emptyView.middleCompose.text = @"NO Message";
//    self.view.emptyView.middleCompose.composeType = FFComposeTypeImageLeft;
//    self.view.emptyView.middleCompose.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
//    self.view.emptyView.middleCompose.speacing = 6;
//    
////    self.view.emptyView.bottomCompose.image = [UIImage imageNamed:@"beianbgs"];
//    self.view.emptyView.bottomCompose.text = @"刷新";
//    self.view.emptyView.bottomCompose.color = [UIColor whiteColor];
//    self.view.emptyView.bottomCompose.composeType = FFComposeTypeImageRight;
//    self.view.emptyView.bottomCompose.contentInset = UIEdgeInsetsMake(2, 10, 2, 10);
//    self.view.emptyView.bottomCompose.speacing = 6;
////    self.view.emptyView.bottomCompose.boderWidth = 1;
////    self.view.emptyView.bottomCompose.boderColor = [UIColor redColor];
//    self.view.emptyView.bottomCompose.radius = 5;
//    self.view.emptyView.bottomCompose.fillColor = [UIColor lightGrayColor];
//    self.view.emptyView.bottomCompose.touchBlock = ^{
//        
//    };
//    
//    self.view.emptyView.topMiddleSpeacing = 10;
//    self.view.emptyView.middleBottomSpeacing = 20;
    
    [self.view showEmptyView];
    
}


@end
