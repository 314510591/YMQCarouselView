//
//  ViewController.m
//  YMQCarouselView
//
//  Created by ymq on 16/3/4.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import "ViewController.h"

#import "YMQCarouselView.h"
#import "YMQPosterView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //轮播广告展示
    YMQCarouselView *carouseView = [[YMQCarouselView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH / 2.0)];
    carouseView.dataArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    [self.view addSubview:carouseView];
    
    
    //轮播海报展示
    YMQPosterView *posterView = [[YMQPosterView alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH / 2.0 + 100, SCREEN_WIDTH, SCREEN_WIDTH / 2.0)];
    posterView.dataArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    [self.view addSubview:posterView];
    
//    UIView *titileView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    titileView.backgroundColor = [UIColor redColor];
////    self.navigationItem.titleView = titileView;
//    
    UIView *titileViewa = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 11)];
    titileViewa.backgroundColor = [UIColor greenColor];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:titileViewa];
    [self.navigationItem setLeftBarButtonItem: barItem];
    
    UINavigationItem * item=self.navigationItem;
    NSArray * array=item.leftBarButtonItems;
    if (array&&array.count!=0){
        //这里需要注意,你设置的第一个leftBarButtonItem的customeView不能是空的,也就是不要设置UIBarButtonSystemItemFixedSpace这种风格的item
        UIBarButtonItem * buttonItem=array[0];
        UIView * view =[[[buttonItem.customView superview] superview] superview];
        [view addSubview:titileViewa];
        
        NSArray * arrayConstraint=view.constraints;
        for (NSLayoutConstraint * constant in arrayConstraint) {
            if (fabs(constant.constant)==16) {
                constant.constant=0;
            }
        }
    }
    
    

    
}

- (UIBarButtonItem *)fixedSpaceWithWidth:(CGFloat)width {
    
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = width;
    return fixedSpace;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
