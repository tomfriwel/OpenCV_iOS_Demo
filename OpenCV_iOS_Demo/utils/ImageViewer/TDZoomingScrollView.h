//
//  TDZoomingScrollView.h
//  TDImageViewer
//
//  Created by tomfriwel on 30/03/2017.
//  Copyright © 2017 tomfriwel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDZoomingScrollView : UIScrollView

- (id)initWithImage:(UIImage *)image;
- (void)displayImage:(UIImage *)image;
@end
