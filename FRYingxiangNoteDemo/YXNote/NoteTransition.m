//
//  NoteTransition.m
//  FRYingxiangNoteDemo
//
//  Created by 张福润 on 16/9/2.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import "NoteTransition.h"

@implementation NoteTransition
- (void)noteTransitionWithSelectCell:(NoteCollectionViewCell *)selectCell visibleCells:(NSArray *)visibleCells originFrame:(CGRect)originFrame finalFrame:(CGRect)finalFrame panViewController:(UIViewController *)panVC listViewController:(UIViewController *)listVC {
    self.selectCell = selectCell;
    self.visibleCells = visibleCells;
    self.originFrame = originFrame;
    self.finalFrame = finalFrame;
    self.panViewController = panVC;
    self.listViewController = listVC;
    UIScreenEdgePanGestureRecognizer * edgPanGR = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    edgPanGR.edges = UIRectEdgeLeft;
    [self.panViewController.view addGestureRecognizer:edgPanGR];
    
}


#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.45;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController * nextVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [[transitionContext containerView] setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    self.selectCell.frame = _isPresent? self.originFrame : self.finalFrame;
    UIView * addView = nextVC.view;
    addView.hidden = _isPresent? true : false;
    [[transitionContext containerView] addSubview:addView];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        for (NoteCollectionViewCell * visibleCell in self.visibleCells) {
            if (visibleCell != self.selectCell) {
                CGRect  frame = visibleCell.frame;
                if (visibleCell.tag < self.selectCell.tag) {
                    CGFloat yDistance = self.originFrame.origin.y - self.finalFrame.origin.y + 30;
                    CGFloat yUpdate = self.isPresent ? yDistance: -yDistance;
                    frame.origin.y -= yUpdate;
                } else if(visibleCell.tag > self.selectCell.tag) {
                    CGFloat yDistance = CGRectGetMaxY(self.finalFrame) - CGRectGetMaxY(self.originFrame) + 30;
                    CGFloat yUpdate = self.isPresent? yDistance : -yDistance;
                    frame.origin.y += yUpdate;
                }
                visibleCell.frame = frame;
                visibleCell.transform = self.isPresent ? CGAffineTransformMakeScale(0.8, 1.0) : CGAffineTransformIdentity;
            }
        }
        
        self.selectCell.frame = self.isPresent ? self.finalFrame : self.originFrame;
        [self.selectCell layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        addView.hidden = false;
        [transitionContext completeTransition:YES];
    }];
    
}


#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.isPresent = YES;
    return self;
    
}


- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.isPresent = NO;
    return self;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.interactionController;
}

- (void)handlePanGesture:(UIScreenEdgePanGestureRecognizer*)recognizer {
    UIView * view = self.panViewController.view;
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self.panViewController dismissViewControllerAnimated:YES completion:^{
            
        }];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:view];
        NSInteger d = fabs(translation.x / CGRectGetWidth(view.bounds));
        [self.interactionController updateInteractiveTransition:d];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        if ([recognizer velocityInView:view].x > 0) {
            [self finishInteractive];
        } else {
            [self.interactionController cancelInteractiveTransition];
            [self.listViewController presentViewController:self.panViewController animated:NO completion:^{
                
            }];
        }
        self.interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
    }
    
}
#pragma mark - EvernoteDetailControllerDelegate
- (void)detailGoBack {
    
}

- (void)finishInteractive {
    [self.interactionController finishInteractiveTransition];
}

@end
