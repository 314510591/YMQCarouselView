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
    YMQCarouselView *carouseView = [[YMQCarouselView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.5, SCREEN_WIDTH)];
    carouseView.dataArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    [self.view addSubview:carouseView];
    
    
    //轮播海报展示
    YMQPosterView *posterView = [[YMQPosterView alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH * 0.5 + 100, 303.0, SCREEN_WIDTH)];
    posterView.dataArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    [self.view addSubview:posterView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
