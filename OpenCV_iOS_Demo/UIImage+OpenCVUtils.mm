//
//  UIImage+OpenCVUtils.m
//  TestOpenCV
//
//  Created by tomfriwel on 14/06/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import <opencv2/opencv.hpp>
#import "UIImage+OpenCV.h"
#import "UIImage+OpenCVUtils.h"

using namespace std;
using namespace cv;

@implementation UIImage (OpenCVUtils)

-(UIImage *)gaussianBlurImage {
    cv::Mat img = [self CVMat];
    cv::Mat gray;
    cv::cvtColor(img, gray, CV_BGR2GRAY);
    cv::GaussianBlur(gray, gray, cv::Size(9 ,9 ),2 ,2);
    return [UIImage imageWithCVMat:gray];
}

-(UIImage *)thresholdImage {
    cv::Mat cvImage = [self CVMat];
    threshold(cvImage, cvImage, 128, 255, cv::THRESH_BINARY);
    return [UIImage imageWithCVMat:cvImage];
}

-(UIImage *)histgramEqualizationImage {
    /// Load image
    Mat src = [self CVMat], dst;
    
    /// Convert to grayscale
    cvtColor( src, src, CV_BGR2GRAY );
    
    /// Apply Histogram Equalization
    equalizeHist( src, dst );
    
    return [UIImage imageWithCVMat:dst];
}

-(UIImage *)sobelOperatorImage {
    /// Load image
    Mat src = [self CVMat], src_gray;
    
    Mat grad;
    int scale = 1;
    int delta = 0;
    int ddepth = CV_16S;
    
//    int c;
    
    GaussianBlur( src, src, cv::Size(3,3), 0, 0, BORDER_DEFAULT );
    
    /// Convert it to gray
    cvtColor( src, src_gray, CV_BGR2GRAY );
    
    /// Generate grad_x and grad_y
    Mat grad_x, grad_y;
    Mat abs_grad_x, abs_grad_y;
    
    /// Gradient X
    //Scharr( src_gray, grad_x, ddepth, 1, 0, scale, delta, BORDER_DEFAULT );
    Sobel( src_gray, grad_x, ddepth, 1, 0, 3, scale, delta, BORDER_DEFAULT );
    convertScaleAbs( grad_x, abs_grad_x );
    
    /// Gradient Y
    //Scharr( src_gray, grad_y, ddepth, 0, 1, scale, delta, BORDER_DEFAULT );
    Sobel( src_gray, grad_y, ddepth, 0, 1, 3, scale, delta, BORDER_DEFAULT );
    convertScaleAbs( grad_y, abs_grad_y );
    
    /// Total Gradient (approximate)
    addWeighted( abs_grad_x, 0.5, abs_grad_y, 0.5, 0, grad );
    
    return [UIImage imageWithCVMat:grad];
}

-(UIImage *)scaleImage:(CGFloat)scale {
    cv::Mat image = [self CVMat];
    cv::Mat outputImage;
    
    cv::Size dstSize = cv::Size(image.size().width*scale, image.size().height*scale);
    
    cv::resize(image, outputImage, dstSize, 0, 0, CV_INTER_LINEAR);
    
    return [UIImage imageWithCVMat:outputImage];
}

-(double)getRotateAngle {
    cv::Mat img = [self CVMat];
    cvtColor(img, img, CV_BGR2GRAY);
    
    // Binarize
    cv::threshold(img, img, 225, 255, cv::THRESH_BINARY);
    
    // Invert colors
    cv::bitwise_not(img, img);
    cv::Mat element = cv::getStructuringElement(cv::MORPH_RECT, cv::Size(5, 3));
    cv::erode(img, img, element);
    
    std::vector<cv::Point> points;
    cv::Mat_<uchar>::iterator it = img.begin<uchar>();
    cv::Mat_<uchar>::iterator end = img.end<uchar>();
    for (; it != end; ++it)
        if (*it)
            points.push_back(it.pos());
    cv::RotatedRect box = cv::minAreaRect(cv::Mat(points));
    double angle = box.angle;
    if (angle < -45.)
        angle += 90.;
    
    cv::Point2f vertices[4];
    box.points(vertices);
    for(int i = 0; i < 4; ++i)
        cv::line(img, vertices[i], vertices[(i + 1) % 4], cv::Scalar(255, 0, 0), 1, CV_AA);
    
//    UIImage *image = [UIImage imageWithCVMat:img];
    
    return angle;
}

-(UIImage *)fixRotation {
    cv::Mat img = [self CVMat];
//    cvtColor(img, img, CV_BGR2GRAY);
    cvtColor(img, img, CV_BGR2GRAY);
    return [UIImage imageWithCVMat:fixRotationb(img)];
}
//-(UIImage *)fixRotation {
//    cv::Mat img = [self CVMat];
//    cvtColor(img, img, CV_BGR2GRAY);
//    
//    //    double angle = [self getRotateAngle];
//    //
//    //    cv::bitwise_not(img, img);
//    //
//    //    std::vector<cv::Point> points;
//    //    cv::Mat_<uchar>::iterator it = img.begin<uchar>();
//    //    cv::Mat_<uchar>::iterator end = img.end<uchar>();
//    //    for (; it != end; ++it)
//    //        if (*it)
//    //            points.push_back(it.pos());
//    //
//    //    cv::RotatedRect box = cv::minAreaRect(cv::Mat(points));
//    //
//    //    cv::Mat rot_mat = cv::getRotationMatrix2D(box.center, angle, 1);
//    //    cv::Mat rotated;
//    //    cv::warpAffine(img, rotated, rot_mat, img.size(), cv::INTER_CUBIC);
//    threshold(img,img,200,255,THRESH_BINARY_INV);
//    
//    std::vector<cv::Point> points;
//    cv::Mat_<uchar>::iterator it = img.begin<uchar>();
//    cv::Mat_<uchar>::iterator end = img.end<uchar>();
//    for (; it != end; ++it)
//        if (*it)
//            points.push_back(it.pos());
//    
//    cv::RotatedRect box = cv::minAreaRect(cv::Mat(points));
//    
//    double angle = box.angle;
//    if (abs(angle)<5) {
//        angle = 45;
//        
//        cv::Mat rot_mat = cv::getRotationMatrix2D(box.center, box.angle, 1);
//        
//        //cv::Mat rotated(src.size(),src.type(),Scalar(255,255,255));
//        Mat rotated;
//        cv::warpAffine(img, rotated, rot_mat, img.size(), cv::INTER_CUBIC);
//        
//        
//        return [[UIImage imageWithCVMat:rotated] fixRotation];
//    }
//    cv::Mat rot_mat = cv::getRotationMatrix2D(box.center, box.angle, 1);
//    
//    //cv::Mat rotated(src.size(),src.type(),Scalar(255,255,255));
//    Mat rotated;
//    cv::warpAffine(img, rotated, rot_mat, img.size(), cv::INTER_CUBIC);
//    
//    
//    return [UIImage imageWithCVMat:rotated];
//}

cv::Mat fixRotationb(cv::Mat img) {
    threshold(img,img,200,255,THRESH_BINARY_INV);
    
    std::vector<cv::Point> points;
    cv::Mat_<uchar>::iterator it = img.begin<uchar>();
    cv::Mat_<uchar>::iterator end = img.end<uchar>();
    for (; it != end; ++it)
        if (*it)
            points.push_back(it.pos());
    
    cv::RotatedRect box = cv::minAreaRect(cv::Mat(points));
    
    double angle = box.angle;
    
    if (abs(angle)==0) {
        angle = 45;
        
        cv::Mat rot_mat = cv::getRotationMatrix2D(box.center, box.angle, 1);
        
        //cv::Mat rotated(src.size(),src.type(),Scalar(255,255,255));
        Mat rotated;
        cv::warpAffine(img, rotated, rot_mat, img.size(), cv::INTER_CUBIC);
        return fixRotationb(rotated);
    }
    cv::Mat rot_mat = cv::getRotationMatrix2D(box.center, box.angle, 1);
    
    Mat rotated;
    cv::warpAffine(img, rotated, rot_mat, img.size(), cv::INTER_CUBIC);
    
    return rotated;
}


-(UIImage *)thresholdImageWithValue:(CGFloat)value {
    cv::Mat cvImage = [self CVMat];
    threshold(cvImage, cvImage, value, 255, cv::THRESH_BINARY);
    return [UIImage imageWithCVMat:cvImage];
}

-(double)darkColorPercent {
    cv::Mat img;
    UIImageToMat(self, img);
//    cv::cvtColor(img, img, CV_RGB2GRAY);
    
    int imgSize = img.rows * img.cols;
//    // you can use whathever for maxval, since it's not used in CV_THRESH_TOZERO
    cv::threshold(img, img, 100, -1, CV_THRESH_TOZERO);
//    UIImage *image = MatToUIImage(img);
    int nonzero = cv::countNonZero(img);
    return (imgSize - nonzero) / double(imgSize);
}


@end
