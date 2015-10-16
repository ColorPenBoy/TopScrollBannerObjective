//
//  BZLoopView.m
//  BannerLoopAnimation
//
//  Created by colorPen on 15/10/13.
//  Copyright © 2015年 Bobi. All rights reserved.
//

#import "BZLoopView.h"

@interface BZLoopView ()

@property (strong , nonatomic) UIImageView *imageView;

@property (assign , nonatomic) int currentIndex;;

@property (strong , nonatomic) NSArray *imgArray;

@property (assign , nonatomic) int imgCount;

@property (strong , nonatomic) NSTimer *timer;

@end

@implementation BZLoopView


- (instancetype)initWithFrame:(CGRect)frame andImageArray:(NSArray *)imageArray
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imgArray = [[NSArray alloc]initWithArray:imageArray];
        self.imgCount = (int)[imageArray count];
        
        //定义图片控件
        UIImageView *imageUU = (UIImageView *)imageArray[0];
        
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds]; //默认图片第一张
        _imageView.image = imageUU.image;
        [self addSubview:_imageView];
        
        [self loadLoopImageGestureRecognizer];
        [self loadLoopImageTimer];
    }
    return self;
}

#pragma mark - 添加定时器
- (void)loadLoopImageTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(leftSwipe:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:UITrackingRunLoopMode];
}

#pragma mark - 添加手势
- (void)loadLoopImageGestureRecognizer
{
    //添加手势 - 左右滑动
    UISwipeGestureRecognizer *leftSwipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:leftSwipeGesture];
    
    UISwipeGestureRecognizer *rightSwipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:rightSwipeGesture];
    
    //添加手势 - 单击图片
    UITapGestureRecognizer *titleImgTapRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BannerImageClick:)];
    [self addGestureRecognizer:titleImgTapRecognizer];
}

#pragma mark - 图片点击事件
- (void)BannerImageClick:(UITapGestureRecognizer *)gesture
{
    NSLog(@"点击图片");
    if (self.oneClickBlock) {
        self.oneClickBlock(_currentIndex);
    }
}
#pragma mark 向左滑动浏览下一张图片
- (void)leftSwipe:(UISwipeGestureRecognizer *)gesture
{
    [self transitionAnimation:YES];
}

#pragma mark 向右滑动浏览上一张图片
- (void)rightSwipe:(UISwipeGestureRecognizer *)gesture
{
    [self transitionAnimation:NO];
}

#pragma mark 转场动画
- (void)transitionAnimation:(BOOL)isNext
{
    //1.创建转场动画对象
    CATransition *transition=[[CATransition alloc]init];
    
    //2.设置动画类型,注意对于苹果官方没公开的动画类型只能使用字符串，并没有对应的常量定义
    transition.type = @"cube";
    
    //设置子类型
    transition.subtype = isNext ? kCATransitionFromRight : kCATransitionFromLeft;
   
    //设置动画时常
    transition.duration = 0.5f;
    
    //设置动画代理
    transition.delegate = self;
    
    //3.设置转场后的新视图添加转场动画
    _imageView.image = [self getImage:isNext];
    
    [_imageView.layer addAnimation:transition forKey:@"KCTransitionAnimation"];
}

#pragma mark 取得当前图片
- (UIImage *)getImage:(BOOL)isNext
{
    if (isNext) {
        _currentIndex = (_currentIndex + 1) % self.imgCount;
    }else{
        _currentIndex = (_currentIndex - 1 + self.imgCount) % self.imgCount;
    }
    
    NSLog(@"图片个数___%d",_currentIndex);
    
    UIImageView *image = (UIImageView *)self.imgArray[_currentIndex];
    
    return image.image;
}


#pragma mark - CAAnimationDelegate
#pragma mark 动画结束
- (void)animationDidStart:(CAAnimation *)anim
{
    self.userInteractionEnabled = NO;
}

#pragma mark 动画结束
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.userInteractionEnabled = YES;
    
    
//    设一个布尔值，开始动画前为NO，开始动画时为YES，动画结束后设为NO；判断那个布尔值就行了
//    
//    非正式协议caanimationdelegate可以帮助你完成那件事
}


@end
