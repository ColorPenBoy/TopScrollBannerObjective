//
//  BZLoopView.h
//  BannerLoopAnimation
//
//  Created by colorPen on 15/10/13.
//  Copyright © 2015年 Bobi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BZLoopViewClickBlock)(int currentIndex);

@interface BZLoopView : UIView

@property (copy , nonatomic)BZLoopViewClickBlock oneClickBlock;

- (instancetype)initWithFrame:(CGRect)frame andImageArray:(NSArray *)imageArray;

@end
