//
//  ViewController.m
//  DFLLabel
//
//  Created by 杭州移领 on 16/7/5.
//  Copyright © 2016年 DFL. All rights reserved.
//

#import "ViewController.h"
#import "DFLLabelView.h"
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height
@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *hotTexts;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      _hotTexts = [@[@"毛衣",@"内裤",@"避孕套",@"充气娃娃娃娃",@"充电器"] mutableCopy] ;
    DFLLabelView *view1 = [[DFLLabelView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 0)];
    view1.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view1];
    view1.texts = _hotTexts;
  
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
