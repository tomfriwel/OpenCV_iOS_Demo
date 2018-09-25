//
//  UIView+Constriant.h
//  Mega
//
//  Created by tomfriwel on 11/11/2016.
//  Copyright © 2016 tom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Constriant)

-(NSArray <NSLayoutConstraint *>*)addAroundConstraintWithItem:(id)view1 toItem:(id)view2;

-(NSArray <NSLayoutConstraint *>*)addAroundConstraintWithItem:(id)view1 toItem:(id)view2 withInsets:(UIEdgeInsets)insets;

-(NSArray <NSLayoutConstraint *>*)addCenterConstraintWithItem:(id)view1 toItem:(id)view2;

-(NSArray <NSLayoutConstraint *>*)addSizeConstraintWithSize:(CGSize)size;

@end
