//
//  NoteCollectionViewCell.h
//  FRYingxiangNoteDemo
//
//  Created by 张福润 on 16/9/2.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titileLeadingCons;
@property (nonatomic , strong) NSLayoutConstraint * horizonallyCons;
@end
