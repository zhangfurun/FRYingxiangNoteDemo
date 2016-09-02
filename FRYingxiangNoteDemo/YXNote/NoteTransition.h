//
//  NoteTransition.h
//  FRYingxiangNoteDemo
//
//  Created by 张福润 on 16/9/2.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NoteDetailViewController.h"
#import "NoteCollectionViewCell.h"

@interface NoteTransition : NSObject<UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate,NoteDetailViewControllerDelegate>

@property (nonatomic , assign) BOOL isPresent;

@property (nonatomic , strong) NoteCollectionViewCell * selectCell;

@property (nonatomic , strong) NSArray * visibleCells;

@property (nonatomic , assign) CGRect originFrame;

@property (nonatomic , assign) CGRect finalFrame;

@property (nonatomic , strong) UIViewController * panViewController;

@property (nonatomic , strong) UIViewController * listViewController;

@property (nonatomic , strong) UIPercentDrivenInteractiveTransition * interactionController;
- (void)noteTransitionWithSelectCell:(NoteCollectionViewCell *)selectCell visibleCells:(NSArray *)visibleCells originFrame:(CGRect)originFrame finalFrame:(CGRect)finalFrame panViewController:(UIViewController *)panVC listViewController:(UIViewController *)listVC;





@end
