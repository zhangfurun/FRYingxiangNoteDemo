//
//  NoteCollectionViewCell.m
//  FRYingxiangNoteDemo
//
//  Created by 张福润 on 16/9/2.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import "NoteCollectionViewCell.h"

@implementation NoteCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        self.layer.masksToBounds = YES;
        
        self.layer.cornerRadius = 7;
    }
    return self;
}




- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 7;
    }
    return self;
}

@end
