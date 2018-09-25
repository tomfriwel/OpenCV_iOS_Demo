//
//  RecognizeViewController.m
//  TestOpenCV
//
//  Created by tomfriwel on 14/06/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

//#import <opencv2/opencv.hpp>
#import "UIImage+OpenCV.h"
#import "UIImage+OpenCVUtils.h"
#import "RecognizeViewController.h"

@interface RecognizeViewController () <UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *accuracyLabel;
@property (strong, nonatomic) UIImageView *showView;
@property (strong, nonatomic) UIImage *image;

@end

@implementation RecognizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Find Circles";
    
    UIImage *image = [UIImage imageNamed:@"test3"];
    
    [self processImage:image];
}


- (IBAction)selectPhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = (id)self;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)accuracySlider:(UISlider *)sender {
    self.accuracyLabel.text = [NSString stringWithFormat:@"accuracy:%f", sender.value];
    if (self.image && self.showView) {
        [self.showView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self findCircles:self.image accuracy:self.slider.value resultBlock:^(int x, int y, int r) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x-r, y-r, r*2, r*2)];
            view.backgroundColor = [UIColor clearColor];
            view.layer.borderColor = [UIColor redColor].CGColor;
            view.layer.cornerRadius = r;
            view.layer.borderWidth = 2;
            [self.showView addSubview:view];
        }];
    }
}

-(void)processImage:(UIImage *)image {
    self.image = image;
    
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    self.showView = imageView;
    
    imageView.image = [image gaussianBlurImage];
    [self.scrollView addSubview:imageView];
    [self.scrollView setContentSize:image.size];
    
    [self findCircles:image accuracy:self.slider.value resultBlock:^(int x, int y, int r) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x-r, y-r, r*2, r*2)];
        view.backgroundColor = [UIColor clearColor];
        view.layer.borderColor = [UIColor redColor].CGColor;
        view.layer.cornerRadius = r;
        view.layer.borderWidth = 2;
        [imageView addSubview:view];
    }];
}

//https://stackoverflow.com/questions/10404062/opencv-dot-target-detection-not-finding-all-targets-and-found-circles-are-offse

-(void)findCircles:(UIImage *)image accuracy:(CGFloat)accuracy resultBlock:(void(^)(int x, int y, int r))resultBlock {
    NSOperationQueue *myQueue = [[NSOperationQueue alloc] init];
    [myQueue addOperationWithBlock:^{
        cv::Mat img = [image CVMat];
        cv::Mat gray;
        cv::cvtColor(img, gray, CV_BGR2GRAY);
        cv::GaussianBlur(gray, gray, cv::Size(9 ,9 ),2 ,2);
        
        std::vector<cv::Vec3f> circles;
        cv::HoughCircles(gray, circles, CV_HOUGH_GRADIENT, 1, gray.rows/20, 100, accuracy, 0, 0);
        
        for( size_t i = 0; i < circles.size(); i++ )
        {
            cv::Point center(cvRound(circles[i][0]), cvRound(circles[i][1]));
            int radius = cvRound(circles[i][2]);
            
            printf("x: %d y: %d r: %d\n",center.x,center.y, radius);
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                resultBlock(center.x,center.y, radius);
            }];
        }
    }];
}

IplImage* convertToIplImage(UIImage*image) {
    CGImageRef imageRef = image.CGImage;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    IplImage *iplImage = cvCreateImage(cvSize(image.size.width, image.size.height), IPL_DEPTH_8U, 4);
    CGContextRef contextRef = CGBitmapContextCreate(iplImage->imageData, iplImage->width, iplImage->height, iplImage->depth, iplImage->widthStep, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrderDefault);
    CGContextDrawImage(contextRef, CGRectMake(0, 0, image.size.width, image.size.height), imageRef);
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpace);
    IplImage *ret = cvCreateImage(cvGetSize(iplImage), IPL_DEPTH_8U, 3);
    cvCvtColor(iplImage, ret, CV_RGB2BGR);
    cvReleaseImage(&iplImage);
    return ret;
}

+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    if (image) {
        CGFloat w = image.size.width;
        CGFloat h = image.size.height;
        if (w>375) {
            h = 375/w*h;
            w = 375;
            image = [[self class] imageWithImage:image scaledToSize:CGSizeMake(w, h)];
        }
        
        [self processImage:image];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
