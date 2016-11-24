//
//  ViewController.m
//  snapshowScreen
//
//  Created by mac on 16/11/24.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import "ViewController.h"


@interface ViewController () {
    
    UIView *_clipView;  //截图部分显示的视图
    CGPoint _startPoint;    //起点
    CGPoint _stopPoint;     //终点
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //显示背景图片
    UIImage *image = [UIImage imageNamed:@"qqq.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = image;
    [self.view addSubview:imageView];
    //创建截图部分显示的视图
    _clipView = [[UIView alloc] init];
    _clipView.backgroundColor = [UIColor lightGrayColor];
    _clipView.alpha = .3;
    [self.view addSubview:_clipView];
    
    
    
}
//获取截图视图的起点
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    _startPoint = [touch locationInView:self.view];
    
    
}
//根据手指移动来确定截图视图
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    _stopPoint = [touch locationInView:self.view];
    _clipView.layer.cornerRadius = 5;
    _clipView.frame = CGRectMake(_startPoint.x, _startPoint.y, _stopPoint.x-_startPoint.x, _stopPoint.y-_startPoint.y);
}
//手指停止滑动，根据截图视图的rect来确定截图部分
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIImage *image = [UIImage imageNamed:@"qqq.jpg"];
    //照片保存到沙盒路径
    //    NSData *data = UIImagePNGRepresentation(image);
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //    NSString *patha = [paths objectAtIndex:0];
    //    NSLog(@"%@", patha);
    //    NSString *imagePath = [patha stringByAppendingString:@"Ahome_tab_icon_3@2x.png.jpg"];
    //    [data writeToFile:imagePath atomically:NO];
    UIGraphicsBeginImageContext(self.view.bounds.size);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(_startPoint.x, _startPoint.y, _stopPoint.x-_startPoint.x, _stopPoint.y-_startPoint.y)];
    [path addClip];
    [image drawInRect:self.view.bounds];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //照片保存在系统相册
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    //不显示截屏视图
    _clipView.frame = CGRectZero;
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
