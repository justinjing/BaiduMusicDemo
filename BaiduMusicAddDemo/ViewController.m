//
//  ViewController.m
//  BaiduMusicAddDemo
//
//  Created by da zhan on 13-6-18.
//  Copyright (c) 2013年 da zhan. All rights reserved.
//

#import "ViewController.h"
#import "TouchView.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize storeListTable;
 
#define DEGREES_TO_RADIANS(x) (3.14159265358979323846 * x / 180.0)
#define EachLabelPostionX 6
#define EachLabelWidth 200

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    musicTitleArray=[[NSMutableArray alloc]initWithCapacity:0];
    
    UIImageView *headerView=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,320, 44)];
    headerView.image=[UIImage imageNamed:@"bar_button_normal.png"];
    headerView.backgroundColor=[UIColor grayColor];
    headerView.userInteractionEnabled=YES;
    
    //Header title label
    UILabel *titleLabel=[[UILabel  alloc]initWithFrame:CGRectMake(100,6,100,30)];
    titleLabel.text=@"百度音乐";
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.font=[UIFont boldSystemFontOfSize:24];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.textAlignment=NSTextAlignmentCenter;// UITextAlignmentCenter;
    [headerView  addSubview:titleLabel];
    [self.view addSubview:headerView];
    storeListTable=[[UITableView alloc]initWithFrame:CGRectMake(0,44, 320,[UIScreen mainScreen].bounds.size.height-20-44-44) style:UITableViewStylePlain];
    storeListTable.delegate=self;
    storeListTable.dataSource=self;
    storeListTable.backgroundColor =[UIColor whiteColor];
    storeListTable.backgroundView=nil;
    [self.view addSubview:storeListTable];
    [storeListTable release];
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"display_toplist_icon_add_press_blue.png"]];
    self.imageView.frame = CGRectMake(310-28,10,28,28);
    [self.view addSubview:self.imageView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"display_toplist_icon_add_press_blue.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"display_toplist_icon_add_normal.png"] forState:UIControlStateHighlighted];
	button.frame = CGRectMake(310-28,10,self.imageView.frame.size.width, self.imageView.frame.size.height);
	[button addTarget:self action:@selector(tranAction:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:button];
    
    
    UIImageView *tt=[[UIImageView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-20-44, 320,44)];
    tt.image = [UIImage imageNamed:@"bar_button_normal.png"] ;
    [self.view addSubview:tt];
    [tt release];
    
    UIImageView *ttDownload=[[UIImageView alloc] initWithFrame:CGRectMake(16, 10, 24,24)];
    ttDownload.image = [UIImage imageNamed:@"mymusicpage_download.png"];
    [tt addSubview:ttDownload];
    [ttDownload release];
    
    NSArray *tempTileArray=[[NSArray alloc]initWithObjects:@"画心-张靓颖",
    @"人鱼传说-张靓颖",
    @"关不上的窗-周传雄",
    @"倾国倾城(青岛啤酒倾国倾城主题歌)",
    @"五月的雪-游鸿明",
    @"台北寂寞部屋-游鸿明",
    @"星月神话(电视剧版《神话》插曲)",
    @"爱的供养-何晟铭",
    @"塞上咏雪花·忆容-锁心玉",
    @"伤不起-郁可唯",
    @"倾尽天下-河图",
    @"末班车-萧煌奇",
    @"忧伤倒数-小昔米",nil];
    [musicTitleArray addObjectsFromArray:tempTileArray];
    [tempTileArray release];
 
}


- (void)tranAction:(id)sender {
    
    CGPoint fromPoint = self.imageView.center;
    
    //路径曲线
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    CGPoint toPoint = CGPointMake(20, 570);
    [movePath addQuadCurveToPoint:toPoint
                     controlPoint:CGPointMake(20,0)];
    
  
    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnim.path = movePath.CGPath;
    moveAnim.removedOnCompletion = YES;
    
    //旋转变化
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    //x，y轴缩小到0.1,Z 轴不变
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.3, 0.3, 1.0)];
    scaleAnim.removedOnCompletion = YES;
    
    //透明度变化
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"alpha"];
    opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnim.toValue = [NSNumber numberWithFloat:0.4];
    opacityAnim.removedOnCompletion = YES;
    
    //路径，旋转，透明度组合起来执行
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:moveAnim, scaleAnim,opacityAnim, nil];
    animGroup.duration = 1;
    [self.imageView.layer addAnimation:animGroup forKey:nil];
    
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 11;
   
}


//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    return  90;
//    
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    static NSString *CellIdentifier = @"Cell33";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        //cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
    UIImageView  *rssImageView =(UIImageView *)[[cell contentView] viewWithTag:22224];
    if (!rssImageView) {
        rssImageView =[[UIImageView alloc] initWithFrame:CGRectMake(EachLabelPostionX,14,24, 24)];
        [rssImageView setImage:[UIImage imageNamed:@"frame.png"]];
        rssImageView.tag = 22224;
        [rssImageView setContentMode:UIViewContentModeScaleToFill];
        [cell.contentView addSubview:rssImageView];
        [rssImageView release];
    }
    
    [rssImageView setImage:[UIImage imageNamed:@"display_toplist_icon_collection_press.png"]];
      
    
    UILabel  *titleLabel = (UILabel *)[[cell contentView]viewWithTag:22221];
    if (!titleLabel) {
        titleLabel =[ [UILabel alloc] initWithFrame:CGRectMake(EachLabelPostionX+rssImageView.frame.size.width+10,5, EachLabelWidth, 40)];
        titleLabel.font = [UIFont systemFontOfSize:20];
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        titleLabel.numberOfLines = 999;
        titleLabel.textColor=[UIColor colorWithRed:0.22 green:0.22 blue:0.21 alpha:1];
        titleLabel.backgroundColor=[UIColor clearColor];
        titleLabel.tag=22221;
        [cell.contentView addSubview:titleLabel];
        [titleLabel release];
    }
    titleLabel.text =[musicTitleArray objectAtIndex:row];
 
    UIImageView *ttDownload=[[UIImageView alloc] initWithFrame:CGRectMake(320-10-24,14,24, 24)];
    ttDownload.image = [UIImage imageNamed:@"display_toplist_icon_add_press_blue.png"];
    [cell.contentView addSubview:ttDownload];
    [ttDownload release];
    
    TouchView  *accesserImageView =(TouchView *)[[cell contentView] viewWithTag:22227];
    if (!accesserImageView) {
        accesserImageView =[[TouchView alloc] initWithFrame:CGRectMake(320-10-24,14,24, 24)];
        accesserImageView.tag = 22227;
        [accesserImageView setContentMode:UIViewContentModeScaleToFill];
        [cell.contentView addSubview:accesserImageView];
        accesserImageView.userInteractionEnabled=YES;
        [accesserImageView release];
    }
    accesserImageView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"display_toplist_icon_add_press_blue.png"]];
    
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
}

 

-(void)dealloc{
    [self.imageView release];
    [super dealloc];
}

@end
