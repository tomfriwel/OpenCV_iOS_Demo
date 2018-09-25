//
//  ThreshViewController.m
//  TestOpenCV
//
//  Created by tomfriwel on 27/06/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import "UIImage+OpenCVUtils.h"
#import "ThreshViewController.h"
#import "UIImage+Utils.h"

@interface ThreshViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *showView;
@property (strong, nonatomic) UIImage *image;

@end

@implementation ThreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.image = [UIImage imageNamed:@"girl.jpg"];
    self.image = [self.image fixOrientation];
    self.showView.image = [self.image thresholdImageWithValue:111];
}

- (IBAction)sliderAction:(UISlider *)sender {
    NSLog(@"%f", sender.value);
    if (self.image) {
        self.showView.image = [self.image thresholdImageWithValue:sender.value];
    }
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
    
    self.image = image;
    self.image = [self.image fixOrientation];
    self.showView.image = [self.image thresholdImageWithValue:111];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
