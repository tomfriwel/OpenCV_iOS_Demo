//
//  ScaleViewController.m
//  TestOpenCV
//
//  Created by tomfriwel on 15/06/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

//#import <opencv2/opencv.hpp>
#import "UIImage+OpenCV.h"
#import "UIImage+OpenCVUtils.h"
#import "ScaleViewController.h"

@interface ScaleViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *showView;

@end

@implementation ScaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Scale";
    self.showView.image = [[UIImage imageNamed:@"profile.jpeg"] scaleImage:0.4];
}



@end
