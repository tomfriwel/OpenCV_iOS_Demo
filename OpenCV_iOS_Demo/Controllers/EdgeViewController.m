//
//  EdgeViewController.m
//  OpenCV_iOS_Demo
//
//  Created by tomfriwel on 2018/9/25.
//  Copyright © 2018 tomfriwel. All rights reserved.
//

#import "UIImage+OpenCVUtils.h"
#import "EdgeViewController.h"
#import "UIImage+Utils.h"
#import "ImagePreviewController.h"

@interface EdgeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *showView;
@property (strong, nonatomic) UIImage *image;
@property (assign, nonatomic) CGFloat thr0;
@property (assign, nonatomic) CGFloat thr1;
@property (assign, nonatomic) int apertureSize;

@end

@implementation EdgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.thr0 = 50;
    self.thr1 = 200;
    self.apertureSize = 3;
    self.image = [UIImage imageNamed:@"girl.jpg"];
    self.image = [self.image fixOrientation];
    [self setup];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPreview:)];
    tap.numberOfTapsRequired = 1;
    self.showView.userInteractionEnabled = YES;
    [self.showView addGestureRecognizer:tap];
}

- (void)setup{
    self.showView.image = [self.image cannyImage:self.thr0 threshold1:self.thr1 apertureSize:self.apertureSize];
}

-(void)showPreview:(UITapGestureRecognizer *)sender {
    NSLog(@"123123");
    UIStoryboard *stb = [UIStoryboard storyboardWithName:@"ImagePreview" bundle:nil];
    ImagePreviewController *vc = [stb instantiateViewControllerWithIdentifier:@"ImagePreviewController"];
    
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.image = self.showView.image;
    //    UIViewController *vc = [[UIViewController alloc] init];
    [self.navigationController presentViewController:nvc animated:YES completion:nil];
}

- (IBAction)slider0Action:(UISlider *)sender {
    NSLog(@"%f", sender.value);
    self.thr0 = sender.value;
    if (self.image) {
        [self setup];
    }
}

- (IBAction)slider1Action:(UISlider *)sender {
    NSLog(@"%f", sender.value);
    self.thr1 = sender.value;
    if (self.image) {
        [self setup];
    }
}
- (IBAction)apertureChange:(UISegmentedControl *)sender {
    NSLog(@"%ld", sender.selectedSegmentIndex);
    NSArray *arr = @[@3, @5, @7];
    self.apertureSize = [arr[sender.selectedSegmentIndex] intValue];
    [self setup];
}

- (IBAction)selectAction:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = (id)self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
//    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    self.image = image;
    self.image = [self.image fixOrientation];
    [self setup];
}

@end
