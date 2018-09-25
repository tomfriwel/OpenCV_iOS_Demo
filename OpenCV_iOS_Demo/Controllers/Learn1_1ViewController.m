//
//  Learn1_1ViewController.m
//  TestOpenCV
//
//  Created by tomfriwel on 15/06/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

//#import <opencv2/opencv.hpp>
#import "UIImage+OpenCV.h"
#import "Learn1_1ViewController.h"

@interface Learn1_1ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *showView;

@end

@implementation Learn1_1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Radial Gradient Transform";
    self.showView.image = [[self class] radialGradientTransform:[UIImage imageNamed:@"profile.jpeg"]];
}

+(UIImage *)radialGradientTransform:(UIImage *)inputImage {
    cv::Mat image = [inputImage CVMat];
    double scale = -1;
    cv::Point center = cv::Point(image.size().width/2, image.size().height/2);
    
    for (int i=0; i<image.size().height; i++) {
        for (int j=0; j<image.size().width; j++) {
            double dx = (double)(j-center.x)/center.x;
            double dy = (double)(i-center.y)/center.y;
            double weight = exp((dx*dx + dy*dy)*scale);
            cv::Vec4b color = image.at<cv::Vec4b>(cv::Point(i,j));
            color[0] = cvRound(color[0]*weight);
            color[1] = cvRound(color[1]*weight);
            color[2] = cvRound(color[2]*weight);
            
            image.at<cv::Vec4b>(cv::Point(i,j)) = color;
        }
    }
    
    return [UIImage imageWithCVMat:image];
}

@end
