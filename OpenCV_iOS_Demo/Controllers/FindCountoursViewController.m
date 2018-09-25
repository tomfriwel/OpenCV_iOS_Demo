//
//  FindCountoursViewController.m
//  TestOpenCV
//
//  Created by tomfriwel on 15/06/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

//#import <opencv2/opencv.hpp>
#import "UIImage+OpenCV.h"
#import "FindCountoursViewController.h"

using namespace std;
using namespace cv;

@interface FindCountoursViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *showView;

@end

@implementation FindCountoursViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Find Contours";
    self.showView.image = [[self class] findContours:[UIImage imageNamed:@"my"]];
}

//https://github.com/yoggy/cv_findcontours_sample/blob/2025bb59641eb6c52b18d519249513e2db47743e/src/cv_findcontours_sample/cv_findcontours_sample.cpp
//+(UIImage *)findContours2:(UIImage *)inputImage {
//    cv::Mat image = [inputImage CVMat];
//    cv::Mat outputImage;
//    
//    std::vector<cv::Scalar> colors;
//    colors.push_back(cv::Scalar(0, 0, 255));
//    colors.push_back(cv::Scalar(0, 255, 0));
//    colors.push_back(cv::Scalar(255, 0, 0));
//    colors.push_back(cv::Scalar(0, 255, 255));
//    colors.push_back(cv::Scalar(255, 255, 0));
//    colors.push_back(cv::Scalar(255, 0, 255));
//    
//    cv::cvtColor(image, image, CV_BGR2GRAY);
//    cv::threshold(image, image, 128, 255, cv::THRESH_BINARY);
//    
//    
//    std::vector<std::vector<cv::Point> > contours;
//    cv::findContours(image, contours, CV_RETR_LIST, CV_CHAIN_APPROX_SIMPLE);
//    
//    //    std::sort(contours.begin(), contours.end(), conter_area_cmp);
//    
//    cv::Mat result_img;
//    image.copyTo(result_img);
//    
//    for (unsigned int i = 0; i < contours.size(); ++i) {
//        // 面積がある程度大きい部分を対象とする
//        if (cv::contourArea(contours[i]) > 100) {
//            cv::polylines(result_img, contours[i], true, colors[i%colors.size()], 2);
//            
//            cv::Rect r = cv::boundingRect(contours[i]);
//            cv::rectangle(result_img, r, cv::Scalar(0, 255, 0), 1);
//            
//            cv::RotatedRect rr = cv::minAreaRect(contours[i]);
//            cv::Point2f ps[4];
//            rr.points(ps);
//            for (int i = 0; i < 4; ++i) {
//                cv::line(result_img, ps[i], ps[(i + 1) % 4], cv::Scalar(255, 0, 0), 1);
//            }
//            
//            cv::RotatedRect re = cv::fitEllipse(contours[i]);
//            
//            cv::ellipse(result_img, re, cv::Scalar(0, 0, 255), 1);
//        }
//    }
//    
//    return [UIImage imageWithCVMat:result_img];
//}

+(UIImage *)findContours:(UIImage *)inputImage {
    Mat image = [inputImage CVMat];
    Mat outputImage;
    
    image.copyTo(outputImage);
    cvtColor(image, image, CV_BGR2GRAY);
    
    
    Scalar color = Scalar(0, 0, 255);
    
    threshold(image, image, 128, 255, THRESH_BINARY);
    
    vector<vector<cv::Point>> contours;
    findContours(image, contours, CV_RETR_LIST, CV_CHAIN_APPROX_NONE);

    for(int i= 0; i < contours.size(); i++) {
        for(int j= 0; j < contours[i].size();j++) {
            cv::circle(outputImage, contours[i][j], 1, color);
        }
    }
    
    return [UIImage imageWithCVMat:outputImage];
}

@end
