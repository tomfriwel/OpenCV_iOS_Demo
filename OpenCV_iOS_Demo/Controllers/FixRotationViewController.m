//
//  FixRotationViewController.m
//  TestOpenCV
//
//  Created by tomfriwel on 22/06/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import "UIImage+OpenCV.h"
#import "FixRotationViewController.h"
#import "UIImage+OpenCVUtils.h"

@interface FixRotationViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *showView;

@end

@implementation FixRotationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UIImage *image = [UIImage imageNamed:@"m8.jpg"];
//    UIImage *image = [UIImage imageNamed:@"rotate0.png"];
    UIImage *image = [UIImage imageNamed:@"verticalImg"];
    
    self.showView.image = [image fixRotation];
}

-(UIImage *)deal:(UIImage *)image {
    cv::Mat img = [image CVMat];
    
    cvtColor(img, img, CV_BGR2GRAY);
    threshold(img,img,222,255, CV_THRESH_BINARY_INV);
    
    cv::Mat kernel = getStructuringElement(cv::MORPH_ELLIPSE, cv::Size(3, 33));
    cv::dilate(img, img, kernel);
    
    UIImage *res = [UIImage imageWithCVMat:img];
    
    return res;
}

@end
