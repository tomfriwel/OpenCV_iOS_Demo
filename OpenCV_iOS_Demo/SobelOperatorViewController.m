//
//  SobelOperatorViewController.m
//  TestOpenCV
//
//  Created by tomfriwel on 16/06/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import "SobelOperatorViewController.h"
#import "UIImage+OpenCVUtils.h"


@interface SobelOperatorViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *showView;

@end

@implementation SobelOperatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Sobel Operator";
    self.showView.image = [[UIImage imageNamed:@"my.png"] sobelOperatorImage];
}

@end
