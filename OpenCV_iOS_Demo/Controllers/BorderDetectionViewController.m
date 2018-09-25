//
//  BorderDetectionViewController.m
//  TestOpenCV
//
//  Created by tomfriwel on 15/06/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

//#import <opencv2/opencv.hpp>
#import "UIImage+OpenCV.h"
#import "BorderDetectionViewController.h"

@interface BorderDetectionViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *showView;

@end

@implementation BorderDetectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Border Detection";
    self.showView.image = [[self class] borderImage:[UIImage imageNamed:@"my.png"]];
}

+(UIImage *)borderImage:(UIImage *)inputImage {
    cv::Mat image = [inputImage CVMat];
    cv::Mat outputImage;
    cv::Canny(image, outputImage, 50, 150);
    
    return [UIImage imageWithCVMat:outputImage];
}

@end
