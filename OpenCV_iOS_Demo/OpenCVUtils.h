//
//  OpenCVUtils.h
//  TestOpenCV
//
//  Created by tomfriwel on 21/06/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>
#import <Foundation/Foundation.h>

extern std::vector<cv::Rect> detectLetters(cv::Mat img, double imageScale);
extern cv::Mat smoothImage(cv::Mat img);
extern void sharpenImage(const cv::Mat &image, cv::Mat &result);
extern void sharpen(const cv::Mat &image,cv::Mat &result);
