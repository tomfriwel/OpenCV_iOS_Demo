//
//  UIImage+Utils.h
//  TestOpenCV
//
//  Created by tomfriwel on 19/06/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utils)

- (UIImage *)scaledToSize:(CGSize)newSize;

- (UIImage *)fixOrientation;

@end
