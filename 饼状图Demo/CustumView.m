//
//  CustumView.m
//  饼状图Demo
//
//  Created by jiangtd on 15/11/25.
//  Copyright © 2015年 jiangtd. All rights reserved.
//

#import "CustumView.h"

@implementation CustumView

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    NSLog(@"rect:%@",NSStringFromCGRect(rect));
    CGContextRef content = UIGraphicsGetCurrentContext();
    CGRect rc = CGContextGetClipBoundingBox(content);
    NSLog(@"rect:%@",NSStringFromCGRect(rc));
    
    
    
    [self drawBingZhuangTuWithSize:rect Context:content];
}

-(void)drawBingZhuangTuWithSize:(CGRect)rect Context:(CGContextRef)content
{
    CGPoint concentPoint = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    CGFloat dir = MIN(rect.size.width, rect.size.height) * 0.5;
    
    NSArray *array = _dataArray;
    
    CGFloat startPro = -M_PI_2;
    CGFloat endPro = 0;
    for (int i = 0; i < array.count; i++) {
        
        endPro = startPro + (([array[i] floatValue] / 100.0) * M_PI * 2);
        
        [[UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0] setFill];
        CGContextSetLineWidth(content, 2.0);
        
        UIBezierPath *path = [UIBezierPath bezierPath];
          [path addArcWithCenter:concentPoint radius:dir startAngle:startPro endAngle:endPro clockwise:YES];
        
        [path addLineToPoint:concentPoint];
        
      
        CGContextAddPath(content, path.CGPath);
        
        CGContextFillPath(content);
        startPro = endPro;
        
    }
    
    [self addTitileBtn];
}

-(void)addTitileBtn
{
    if (_isAddBtn) {
        return;
    }
    CGFloat btnSizeHight = MIN(self.frame.size.height, self.frame.size.width) * 0.5;
    CGFloat btnSizeWidth = btnSizeHight * 0.5;
    
    NSArray *dataSource = _dataArray;
    CGFloat startPro = 0;
    CGFloat endPro = 0;
    
    for (int i = 0; i<dataSource.count; i++)
    {
        
        endPro = startPro + (([dataSource[i] floatValue] / 100.0) * M_PI * 2);
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor clearColor];
        btn.frame = CGRectMake(0, 0, btnSizeWidth, btnSizeHight);
        btn.layer.anchorPoint = CGPointMake(0.5, 1);
        btn.center = CGPointMake(self.frame.size.width * .5, self.frame.size.height * .5);
        
        [self addSubview:btn];
        CGFloat pro = ([dataSource[i] floatValue] / 100.0) * M_PI + startPro;
        
        CGAffineTransform tansform = CGAffineTransformMakeRotation(pro);
        btn.transform = tansform;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:[NSString stringWithFormat:@"%ld%%",(long)[dataSource[i] integerValue]] forState:UIControlStateNormal];
        
        startPro = endPro;
        
    }
    _isAddBtn = YES;
}

-(void)btnClicked:(UIButton*)btn
{
    NSLog(@"btn Clicked");
}

@end
















