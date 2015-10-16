//
//  ViewController.m
//  BannerLoopAnimation
//
//  Created by colorPen on 15/10/13.
//  Copyright © 2015年 Bobi. All rights reserved.
//

#import "ViewController.h"
#import "BZLoopView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 5; i++) {
        
        NSString *str = [NSString stringWithFormat:@"%i.jpg", i];
        
        UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:str]];
        [dataArray addObject:image];
    }
    
    BZLoopView *imgView = [[BZLoopView alloc]initWithFrame:self.view.bounds andImageArray:[NSArray arrayWithArray:dataArray]];
    imgView.oneClickBlock = ^(int currentIndex){
        
        NSLog(@"点击图片__++__%d",currentIndex);
        
    };
    
    [self.view addSubview:imgView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
