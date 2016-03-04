//
//  YSWCarousel.h
//  Collection
//
//  Created by ymq on 16/2/26.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

typedef void(^PageChange)(NSInteger page);
typedef void(^SelectPage)(NSInteger page);
typedef void(^UserDragStatus)(BOOL isDraging);
@interface YMQCarouselView : UITableView

@property (strong, nonatomic) NSArray *dataArray;
@property (copy, nonatomic) PageChange pageChange;
@property (copy, nonatomic) SelectPage selectPage;
@property (copy, nonatomic) UserDragStatus userDrag;

@end
