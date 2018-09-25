//
//  UIView+Constriant.m
//  Mega
//
//  Created by tomfriwel on 11/11/2016.
//  Copyright © 2016 tom. All rights reserved.
//

#import "UIView+Constriant.h"

@implementation UIView (Constriant)

-(NSArray <NSLayoutConstraint *>*)addAroundConstraintWithItem:(id)view1 toItem:(id)view2 {
    // Top constraint
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    // Bottom constraint
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    // Left constraint
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    // Right constraint
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    
    NSArray *constraints = @[top, left, bottom, right];
    
    [self addConstraints:constraints];
    
    return constraints;
}

-(NSArray <NSLayoutConstraint *>*)addAroundConstraintWithItem:(UIView *)view1 toItem:(UIView *)view2 withInsets:(UIEdgeInsets)insets {
    // Top constraint
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeTop multiplier:1 constant:insets.top];
    // Bottom constraint
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeBottom multiplier:1 constant:insets.bottom];
    // Left constraint
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeLeft multiplier:1 constant:insets.left];
    // Right constraint
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeRight multiplier:1 constant:insets.right];
    
    NSArray *constraints = @[top, left, bottom, right];
    
    [self addConstraints:constraints];
    
    return constraints;
}

-(NSArray <NSLayoutConstraint *>*)addCenterConstraintWithItem:(id)view1 toItem:(id)view2 {
    // X center constraint
    NSLayoutConstraint *xCenterConstraint = [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    
    // Y center constraint
    NSLayoutConstraint *yCenterConstraint = [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    
    NSArray *constraints = @[xCenterConstraint, yCenterConstraint];
    
    [self addConstraints:constraints];
    
    return constraints;
}

-(NSArray <NSLayoutConstraint *>*)addSizeConstraintWithSize:(CGSize)size {
    // Height constraint
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self
                                                      attribute:NSLayoutAttributeWidth
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:nil
                                                      attribute: NSLayoutAttributeNotAnAttribute
                                                     multiplier:1
                                                       constant:size.width];
    
    // Height constraint
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self
                                                      attribute:NSLayoutAttributeHeight
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:nil
                                                      attribute: NSLayoutAttributeNotAnAttribute
                                                     multiplier:1
                                                       constant:size.height];
    
    NSArray *constraints = @[widthConstraint, heightConstraint];
    
    [self addConstraints:constraints];
    
    return constraints;
}

@end
