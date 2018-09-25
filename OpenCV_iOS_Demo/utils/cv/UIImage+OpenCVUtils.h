//
//  UIImage+OpenCVUtils.h
//  TestOpenCV
//
//  Created by tomfriwel on 14/06/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (OpenCVUtils)

-(UIImage *)gaussianBlurImage;

-(UIImage *)thresholdImage;

-(UIImage *)histgramEqualizationImage;


//http://docs.opencv.org/2.4/doc/tutorials/imgproc/imgtrans/sobel_derivatives/sobel_derivatives.html#sobel-derivatives
-(UIImage *)sobelOperatorImage;

-(UIImage *)scaleImage:(CGFloat)scale;

-(UIImage *)fixRotation;

-(UIImage *)thresholdImageWithValue:(CGFloat)value;

-(double)darkColorPercent;

-(UIImage *)cannyImage:(CGFloat)thr0 threshold1:(CGFloat)thr1;

@end
