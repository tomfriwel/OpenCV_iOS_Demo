//
//  DrawViewController.m
//  TestOpenCV
//
//  Created by tomfriwel on 15/06/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

//#import <opencv2/opencv.hpp>
#import "UIImage+OpenCV.h"
#import "DrawViewController.h"

using namespace std;
using namespace cv;

@interface DrawViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *showView;

@end

@implementation DrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Draw";
    self.showView.image = [[self class] drawFace];
}

+(UIImage *)drawFace {
    Scalar color = Scalar(255, 255, 255);
//    cv::Point pt1_rect;
//    cv::Point pt2_rect;
//    
//    cv::Point center;
//    
//    cv::Point center_l_eye;
//    cv::Point center_r_eye;
//    cv::Size axes_eye;
//    
//    double angle_l_eye = 15;
//    double angle_r_eye = -15;
//    
//    double start_angle_eye = 0;
//    double start_end_eye = 360;
    cv::Point start = cv::Point(10, 10);
    cv::Point end = cv::Point(100, 100);
    cv::Point center = cv::Point(150, 150);
    cv::Size size = cv::Size(100, 150);
    
    Mat img = Mat::zeros(600, 600, CV_8UC3);
    line(img, start, end, color);
    rectangle(img, start, end, color);
    circle(img, center, 45, color);
    ellipse(img, center, size, 20, 0, 270, color, CV_FILLED);
    
    
    return [UIImage imageWithCVMat:img];
}

@end
