//
//  ViewController.m
//  MaskImageView
//
//  Created by zhouyong on 15/11/5.
//  Copyright (c) 2015年 sytuzhouyong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *maskImageView;


@end

@implementation ViewController

// http://stackoverflow.com/questions/20453213/mask-arbitrarily-sized-uiimageview-with-resizable-uiimage-mask
// http://blog.sina.com.cn/s/blog_78a55c9f0101037i.html

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addSubviews];
    
    UIEdgeInsets insets2 = UIEdgeInsetsMake(6, 5, 6, 12);
    
    UIImage *maskImage = [UIImage imageNamed:@"image_mask_right"];
    maskImage = [maskImage resizableImageWithCapInsets:insets2 resizingMode:UIImageResizingModeStretch];
    self.maskImageView.image = maskImage;
    
    UIImage *originImage = [UIImage imageNamed:@"1.jpg"];
    self.imageView.image = originImage;
    
    CGFloat width = maskImage.size.width;
    CGFloat height = maskImage.size.height;
    
    CALayer *mask = [CALayer layer];
    mask.contents = (id)[maskImage CGImage];
    mask.contentsCenter = CGRectMake(insets2.left/width, insets2.top/height, 1.0/maskImage.size.width, 1.0/maskImage.size.height);
    mask.frame = self.imageView.layer.bounds;
    mask.contentsScale = [UIScreen mainScreen].scale;
    self.imageView.layer.mask = mask;
    
}

- (void)addSubviews {
    self.imageView = [self createImageViewWithFrame: CGRectMake(20, 100, 200, 100)];
    self.maskImageView = [self createImageViewWithFrame: CGRectMake(20, 300, 200, 100)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.maskImageView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:self.imageView];
    [self.view addSubview: self.maskImageView];
}

- (UIImageView *)createImageViewWithFrame: (CGRect)frame {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.layer.masksToBounds = YES;
    return imageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
