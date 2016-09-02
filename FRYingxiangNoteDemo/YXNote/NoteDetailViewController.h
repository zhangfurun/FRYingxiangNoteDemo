//
//  NoteDetailViewController.h
//  FRYingxiangNoteDemo
//
//  Created by 张福润 on 16/9/2.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NoteDetailViewControllerDelegate <NSObject>

- (void)detailGoBack;

@end
@interface NoteDetailViewController : UIViewController
@property (nonatomic ,weak) id<NoteDetailViewControllerDelegate>delegate;
@end
