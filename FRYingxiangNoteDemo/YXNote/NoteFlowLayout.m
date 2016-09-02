//
//  NoteFlowLayout.m
//  FRYingxiangNoteDemo
//
//  Created by 张福润 on 16/9/2.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import "NoteFlowLayout.h"

@implementation NoteFlowLayout
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(ItemW, ItemH);
        self.headerReferenceSize = CGSizeMake(ScreenW, PaddingV);
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    CGFloat offsetY = self.collectionView.contentOffset.y;
    NSArray * attrArray = [super layoutAttributesForElementsInRect:rect];
    CGFloat collectionViewFrameHeight = self.collectionView.frame.size.height;
    CGFloat collectionViewContentHeight = self.collectionView.contentSize.height;
    CGFloat ScrollViewContentInsetBottom = self.collectionView.contentInset.bottom;
    CGFloat bottomOffset = offsetY + collectionViewFrameHeight - collectionViewContentHeight - ScrollViewContentInsetBottom;
    NSInteger numOfItems = self.collectionView.numberOfSections;
    
    for (UICollectionViewLayoutAttributes * attr in attrArray) {
        if (attr.representedElementCategory == UICollectionElementCategoryCell) {
            CGRect cellRect = attr.frame;
            if (offsetY <= 0) {
                CGFloat distance = fabs(offsetY)/SpringFactor;
                cellRect.origin.y += offsetY + distance * (attr.indexPath.section + 1);
                
            } else if (bottomOffset > 0) {
                CGFloat distance = bottomOffset/SpringFactor;
                cellRect.origin.y += bottomOffset - distance * (numOfItems - attr.indexPath.section);
            }
            attr.frame = cellRect;
        }
    }
    return attrArray;
    
}


@end
