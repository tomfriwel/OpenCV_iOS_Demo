//
//  EditorImagePreviewController.h
//  Mega
//
//  Created by tomfriwel on 10/01/2017.
//  Copyright © 2017 jue.so. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditorImagePreviewController : UIViewController

+(instancetype)defaultViewController;

//@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong,nonatomic) UIImage *image;

@end
