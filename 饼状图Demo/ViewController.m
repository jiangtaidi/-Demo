//
//  ViewController.m
//  饼状图Demo
//
//  Created by jiangtd on 15/11/25.
//  Copyright © 2015年 jiangtd. All rights reserved.
//

#import "ViewController.h"
#import "CustumView.h"


@interface ViewController ()
@property(nonatomic,weak)CustumView *vView;
@property(nonatomic,strong)NSCache *cache;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self custumViewTest];
    _cache = [[NSCache alloc] init];
    [_cache setObject:@"hehh" forKey:@"hehe"];
    
}

-(void)custumViewTest
{
    NSArray *dataSource = @[@20,@30,@10,@30,@10];
    CustumView *cView = [[CustumView alloc] initWithFrame:CGRectMake(0, 100, 400, 350)];
//    cView.backgroundColor = [UIColor redColor];
    cView.dataArray = dataSource;
    _vView = cView;
    [self.view addSubview:cView];
    
}

- (IBAction)btnClicked:(id)sender
{
    [_vView setNeedsDisplayInRect:CGRectMake(0, 0, 30, 30)];
    NSLog(@"str:%@",[_cache objectForKey:@"hehe"]);
}



@end
