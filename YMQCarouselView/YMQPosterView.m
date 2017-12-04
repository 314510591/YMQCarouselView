//
//  YMQPosterView.m
//  YMQCarouselView
//
//  Created by ymq on 16/3/4.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import "YMQPosterView.h"
#import "YMQPosterCell.h"

#define POSTERWIDTH 189.0
#define POSTERHEIGHT 303.0

@interface YMQPosterView ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation YMQPosterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    self.delegate = self;
    self.dataSource = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.transform = CGAffineTransformMakeRotation(-M_PI / 2);
    self.decelerationRate = 0;
//    [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    [self registerNib:[UINib nibWithNibName:@"YMQPosterCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"YMQPosterCell"];
    
    
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    
    [self reloadData];
    CGFloat spaceW = POSTERWIDTH - (self.frame.size.width - POSTERWIDTH) / 2.0;
    CGFloat offsetX = POSTERWIDTH + spaceW;
    if (dataArray.count > 0 && dataArray.count == 1)
    {
        offsetX = 0;
    }
    [self setContentOffset:CGPointMake(0 ,offsetX)];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat spaceW = POSTERWIDTH - (self.frame.size.width - POSTERWIDTH) / 2.0;
    CGFloat offsetX = POSTERWIDTH + spaceW;
    if (self.contentOffset.y > 0)
    {
        if (self.contentOffset.y >= POSTERWIDTH * (self.dataArray.count + 1) + spaceW)
        {
            [self setContentOffset:CGPointMake(0, offsetX)];
        }
        else if (self.contentOffset.y <= spaceW)
        {
            [self setContentOffset:CGPointMake(0, POSTERWIDTH * (self.dataArray.count ) + spaceW)];
        }
    }
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count == 1 ? 1 : self.dataArray.count + 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YMQPosterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YMQPosterCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.transform = CGAffineTransformMakeRotation(M_PI / 2);
    
//    UIImageView *imageView = [cell viewWithTag:4];
//    if (!imageView)
//    {
//        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height)];
//        imageView.tag = 4;
//        [cell addSubview:imageView];
//    }
    
    NSInteger page = 0;
    if (indexPath.row == 0)
    {
        page = self.dataArray.count - 1;
    }
    else if (indexPath.row == 1)
    {
        page = self.dataArray.count;
    }
    else if (indexPath.row - 2 == self.dataArray.count)
    {
        page = 1;
    }
    else if (indexPath.row - 2 == self.dataArray.count + 1)
    {
        page = 2;
    }
    else
    {
        page = indexPath.row - 1;
    }
    
//    cell.textLabel.text = _dataArray[page - 1];
    
    cell.contentImage.backgroundColor = [UIColor colorWithRed:page * 20 / 255.0 green:page * 20 / 255.0 blue:page * 20 / 255.0 alpha:1];
    
    //    [imageView sd_setImageWithURL:[self.dataArray objectAtIndex:(page - 1)] placeholderImage:[UIImage imageNamed:@"placeholder.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    //        if (error != nil) {
    //            imageView.image =[UIImage imageNamed:@"placeholder.png"];
    //        }
    //
    //    }];
    
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return POSTERWIDTH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.selectPage)
    {
        NSInteger page = 0;
        if (indexPath.row == 0)
        {
            page = self.dataArray.count - 1;
        }
        else if (indexPath.row == 1)
        {
            page = self.dataArray.count;
        }
        else if (indexPath.row - 2 == self.dataArray.count)
        {
            page = 1;
        }
        else if (indexPath.row - 2 == self.dataArray.count + 1)
        {
            page = 2;
        }
        else
        {
            page = indexPath.row - 1;
        }
        
        self.selectPage(page - 1);
    }
}

#pragma UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.userDrag)
    {
        self.userDrag(YES);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    
    CGFloat index = offset.y / bounds.size.width;
    
    NSInteger page = 0;
    if (index == 0)
    {
        page = self.dataArray.count - 1;
    }
    else if (index == 1)
    {
        page = self.dataArray.count;
    }
    else if (index - 2 == self.dataArray.count)
    {
        page = 1;
    }
    else if (index - 3 == self.dataArray.count)
    {
        page = 2;
    }
    else
    {
        page = index - 1;
    }
    
    if (self.pageChange)
    {
        self.pageChange(page - 1);
    }
    if (self.userDrag)
    {
        self.userDrag(NO);
    }
    [self resetX];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    
    CGFloat index = offset.y / bounds.size.width;
    
    NSInteger page = 0;
    if (index == 0)
    {
        page = self.dataArray.count - 1;
    }
    else if (index == 1)
    {
        page = self.dataArray.count;
    }
    else if (index - 2 == self.dataArray.count)
    {
        page = 1;
    }
    else if (index - 3 == self.dataArray.count)
    {
        page = 2;
    }
    else
    {
        page = index - 1;
    }
    
    if (self.pageChange)
    {
        self.pageChange(page - 1);
    }
}

- (void)resetX
{
    CGFloat spaceW = POSTERWIDTH - (self.frame.size.width - POSTERWIDTH) / 2.0;
    NSInteger index = self.contentOffset.y / POSTERWIDTH;
    CGFloat offsetX = index * POSTERWIDTH + spaceW;
    [self setContentOffset:CGPointMake(0, offsetX) animated:YES];
}

@end
