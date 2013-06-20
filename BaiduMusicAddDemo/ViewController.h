//
//  ViewController.h
//  BaiduMusicAddDemo
//
//  Created by da zhan on 13-6-18.
//  Copyright (c) 2013年 da zhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *storeListTable;
    NSMutableArray *musicTitleArray;
}


@property (nonatomic, retain) UITableView *storeListTable;
@property (strong, nonatomic) UIImageView *imageView;

- (void)tranAction:(id)sender;


@end
