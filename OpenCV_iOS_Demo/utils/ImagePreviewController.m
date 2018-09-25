//
//  EditorImagePreviewController.m
//  Mega
//
//  Created by tomfriwel on 10/01/2017.
//  Copyright © 2017 jue.so. All rights reserved.
//

#import "EditorImagePreviewController.h"

#import "TDZoomingScrollView.h"
#import "UIView+Constriant.h"

@interface EditorImagePreviewController ()

@property (nonatomic, strong) TDZoomingScrollView *scrollView;
@property (nonatomic, assign) BOOL toggle;

@end

@implementation EditorImagePreviewController

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

+(instancetype)defaultViewController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Editor" bundle:nil];
    EditorImagePreviewController *vc = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
    return vc;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.toggle = NO;
    
    self.scrollView = [[TDZoomingScrollView alloc] initWithImage:self.image];
    self.scrollView.frame = self.view.frame;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    [self.scrollView displayImage:self.image];
    
    [self.scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleScrollViewTap:)]];
    
    if (self.image) {
        CGSize size = self.image.size;
        size.width *= self.scrollView.zoomScale;
        size.height *= self.scrollView.zoomScale;
        self.preferredContentSize = size;
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!self.toggle) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    }
    else {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

-(void)handleScrollViewTap:(id)sender {
    if (self.toggle) {
        self.scrollView.backgroundColor = [UIColor whiteColor];
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    }
    else {
        self.scrollView.backgroundColor = [UIColor blackColor];
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    }
    self.toggle = !self.toggle;
}



#ifdef __IPHONE_9_0
-(NSArray<id<UIPreviewActionItem>> *)previewActionItems{
    UIPreviewAction * act1 = [UIPreviewAction actionWithTitle:@"test1" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
    }];
    UIPreviewAction * act2 = [UIPreviewAction actionWithTitle:@"test2" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
    }];
    
    return @[act1, act2];
}
#endif

-(void)dealloc {
    NSLog(@"dealloc %@", NSStringFromClass([self class]));
}

@end
