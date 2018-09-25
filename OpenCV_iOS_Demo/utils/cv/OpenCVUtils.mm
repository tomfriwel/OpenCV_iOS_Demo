//
//  OpenCVUtils.m
//  TestOpenCV
//
//  Created by tomfriwel on 21/06/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import "OpenCVUtils.h"
#import "UIImage+OpenCV.h"

std::vector<cv::Rect> detectLetters(cv::Mat img, double imageScale)
{
    std::vector<cv::Rect> boundRect;
//    cv::Mat img_gray, img_sobel, img_threshold, element;
//    element = getStructuringElement(cv::MORPH_RECT, cv::Size(13, 5) );
    
    //https://stackoverflow.com/questions/23506105/extracting-text-opencv
    //    cvtColor(img, img_gray, CV_BGR2GRAY);
    //    cv::threshold(img_gray, img_gray, 128, 255, CV_THRESH_BINARY);
    //    GaussianBlur(img_gray, img_gray, cv::Size(3, 3), 0);
    ////    cv::Sobel(img_gray, img_sobel, CV_8U, 1, 0, 3, 1, 0, cv::BORDER_DEFAULT);
    //    Sobel(img_gray, img_sobel, CV_8U, 1, 0, -1);
    //    cv::threshold(img_sobel, img_threshold, 0, 255, CV_THRESH_OTSU+CV_THRESH_BINARY);
    //
    //    cv::morphologyEx(img_threshold, img_threshold, CV_MOP_CLOSE, element); //Does the trick
    //
    
    //http://www.pyimagesearch.com/2015/11/30/detecting-machine-readable-zones-in-passport-images/
    
    //    Mat rectKernel, sqKernel;
    //    rectKernel = getStructuringElement(cv::MORPH_RECT, cv::Size(13, 5) );
    //    sqKernel = getStructuringElement(cv::MORPH_RECT, cv::Size(21, 21));
    //
    //    cvtColor(img, img_gray, CV_BGR2GRAY);
    //    GaussianBlur(img_gray, img_gray, cv::Size(3, 3), 0);
    //
    //    Mat gradX;
    //    cv::morphologyEx(img_gray, gradX, CV_MOP_BLACKHAT, element); //Does the trick
    //
    //    Sobel(gradX, gradX, CV_8U, 1, 0, -1);
    //    gradX = cv::abs(gradX);
    //
    //    double minVal, maxVal;
    //    cv::minMaxIdx(gradX, &minVal, &maxVal);
    //
    ////    Mat temp0, temp1;
    ////    temp0 = gradX - minVal;
    ////    temp0 = 255 * temp0;
    ////    temp0 = temp0 / (maxVal - minVal);
    //    gradX = (255 * ((gradX - minVal) / (maxVal - minVal)));//.astype("uint8")
    //
    ////    cvtColor(temp0, gradX, CV_BGR2GRAY);
    //    cv::morphologyEx(gradX, gradX, CV_MOP_CLOSE, rectKernel);
    //    threshold(gradX, img_threshold, 0, 255, THRESH_BINARY | THRESH_OTSU);
    //
    ////    img_threshold = img_threshold;
    
    //https://stackoverflow.com/a/23556997/6279975
//    cvtColor(img, img_gray, CV_BGR2GRAY);
//    
//    //    GaussianBlur(img_gray, img_gray, cv::Size(77, 77), 0);
//    cv::threshold(img_gray, img_gray, thresholdValue, 255, CV_THRESH_BINARY_INV);
//    cv::Mat kernel = getStructuringElement(cv::MORPH_CROSS, cv::Size(130*imageScale, 3*imageScale) );
//    cv::dilate(img_gray, img_threshold, kernel);
//    
//    
//    std::vector< std::vector< cv::Point> > contours;
//    cv::findContours(img_threshold, contours, cv::RETR_EXTERNAL, cv::CHAIN_APPROX_NONE);
    
    
    //chen version
    cv::Mat tempMat = img;
    cv::Mat gray;
    cv::cvtColor(tempMat, gray, CV_RGB2GRAY);
    cv::threshold(gray, tempMat, 80, 255, CV_THRESH_BINARY);
    cv::Mat blackedMat = tempMat.clone();
    
    cv::Mat kernel = getStructuringElement(cv::MORPH_RECT, cv::Size(130, 20) );
    cv::dilate((255 - tempMat), tempMat, kernel);
    
    // 检索轮廓并返回检测到的轮廓的个数
    std::vector< std::vector< cv::Point> > contours;
    cv::findContours(tempMat, contours, cv::RETR_EXTERNAL, cv::CHAIN_APPROX_NONE);
    
//    cv::drawContours(gray , contours ,-1 , cv::Scalar(0) , 2);
    
    
    //    std::vector< std::vector< cv::Point> > contours;
    //    cv::findContours(img_threshold, contours, 0, 1);
//    std::vector<std::vector<cv::Point> > contours_poly( contours.size() );
    
//    UIImage *image = [UIImage imageWithCVMat:tempMat];
    
    int max=200*imageScale, min=40*imageScale;
    //    for( int i = 0; i < contours.size(); i++ ) {
    //        cv::Rect appRect(boundingRect(contours[i]));
    //        if (appRect.height > max && appRect.width > max) {
    //            continue;
    //        }
    //        if (appRect.height < min || appRect.width < min) {
    //            continue;
    //        }
    //        appRect.width += 60;
    ////        appRect.height += 15;
    //        appRect.x -= 30;
    ////        appRect.y -= 7.5;
    //        rectangle(img_threshold, appRect, cv::Scalar(255,0,0), CV_FILLED);
    //    }
    
    //    cv::findContours(img_threshold, contours, RETR_EXTERNAL, CHAIN_APPROX_NONE);
    
    for( int i = 0; i < contours.size(); i++ ) {
        cv::Rect appRect(boundingRect(contours[i]));
        if (appRect.height > max && appRect.width > max) {
            continue;
        }
        if (appRect.height < min || appRect.width < min) {
            continue;
        }
        appRect.width += 60*imageScale;
        appRect.height += 15*imageScale;
        appRect.x -= 30*imageScale;
        appRect.y -= 7.5*imageScale;
        boundRect.push_back(appRect);
    }
    
    //    image = [UIImage imageWithCVMat:img_threshold];
    
    //    for( int i = 0; i < contours.size(); i++ )
    //    {
    //        if (contours[i].size()>100)
    //        {
    //            cv::approxPolyDP( cv::Mat(contours[i]), contours_poly[i], 3, true );
    //            cv::Rect appRect( boundingRect( cv::Mat(contours_poly[i]) ));
    //            appRect += cv::Size(20, 20);
    //            appRect -= cv::Point(10, 10);
    //            if (appRect.width>appRect.height) {
    //                boundRect.push_back(appRect);
    //            }
    //        }
    //    }
    return boundRect;
}

cv::Mat smoothImage(cv::Mat img) {
    cv::bilateralFilter(img, img,9,75,75);
//    
//    cv::Mat whole_image= img;
//    whole_image.convertTo(whole_image,CV_32FC3,1.0/255.0);
//    cv::resize(whole_image,whole_image,img.size());
//    img.convertTo(img,CV_32FC3,1.0/255.0);
//    
//    cv::Mat bg=cv::Mat(img.size(),CV_32FC3);
//    bg=cv::Scalar(1.0,1.0,1.0);
//    
//    // Prepare mask
//    cv::Mat mask;
//    cv::Mat img_gray;
//    cv::cvtColor(img,img_gray,cv::COLOR_BGR2GRAY);
//    img_gray.convertTo(mask,CV_32FC1);
//    threshold(1.0-mask,mask,0.9,1.0,cv::THRESH_BINARY_INV);
//    
//    cv::GaussianBlur(mask,mask,cv::Size(21,21),11.0);
////    imshow("result",mask);
////    cv::waitKey(0);
//    
//    
//    // Reget the image fragment with smoothed mask
//    cv::Mat res;
//    
//    std::vector<cv::Mat> ch_img(3);
//    std::vector<cv::Mat> ch_bg(3);
//    cv::split(whole_image,ch_img);
//    cv::split(bg,ch_bg);
//    ch_img[0]=ch_img[0].mul(mask)+ch_bg[0].mul(1.0-mask);
//    ch_img[1]=ch_img[1].mul(mask)+ch_bg[1].mul(1.0-mask);
//    ch_img[2]=ch_img[2].mul(mask)+ch_bg[2].mul(1.0-mask);
//    cv::merge(ch_img,res);
//    cv::merge(ch_bg,bg);
    return img;
}

void sharpenImage(const cv::Mat &image, cv::Mat &result)
{
    //创建并初始化滤波模板
    cv::Mat kernel(3,3,CV_32F,cv::Scalar(0));
    kernel.at<float>(1,1) = 5.0;
    kernel.at<float>(0,1) = -1.0;
    kernel.at<float>(1,0) = -1.0;
    kernel.at<float>(1,2) = -1.0;
    kernel.at<float>(2,1) = -1.0;
    
    result.create(image.size(),image.type());
    
    //对图像进行滤波
    cv::filter2D(image,result,image.depth(),kernel);
}

void sharpen(const cv::Mat &img,cv::Mat &result){
    result.create(img.size(), img.type());
    //处理边界内部的像素点, 图像最外围的像素点应该额外处理
    for (int row = 1; row < img.rows-1; row++)
    {
        //前一行像素点
        const uchar* previous = img.ptr<const uchar>(row-1);
        //待处理的当前行
        const uchar* current = img.ptr<const uchar>(row);
        //下一行
        const uchar* next = img.ptr<const uchar>(row+1);
        uchar *output = result.ptr<uchar>(row);
        int ch = img.channels();
        int starts = ch;
        int ends = (img.cols - 1) * ch;
        for (int col = starts; col < ends; col++)
        {
            //输出图像的遍历指针与当前行的指针同步递增, 以每行的每一个像素点的每一个通道值为一个递增量, 因为要考虑到图像的通道数
            *output++ = cv::saturate_cast<uchar>(5 * current[col] - current[col-ch] - current[col+ch] - previous[col] - next[col]);
        }
    } //end loop
    //处理边界, 外围像素点设为 0
    result.row(0).setTo(cv::Scalar::all(0));
    result.row(result.rows-1).setTo(cv::Scalar::all(0));
    result.col(0).setTo(cv::Scalar::all(0));
    result.col(result.cols-1).setTo(cv::Scalar::all(0));
}
