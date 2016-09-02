//
//  NoteFlowLayout.h
//  FRYingxiangNoteDemo
//
//  Created by 张福润 on 16/9/2.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ScreenW  [[UIScreen mainScreen] bounds].size.width
#define ScreenH  [[UIScreen mainScreen] bounds].size.height

#define PaddingH 10
#define PaddingV 10

#define ItemW  ScreenW - 2*PaddingH
#define ItemH  45

#define SpringFactor 10

@interface NoteFlowLayout : UICollectionViewFlowLayout

@end
