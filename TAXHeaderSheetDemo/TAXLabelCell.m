//
//  TAXLabelCell.m
//  TAXSpreadSheetDemo
//
//  Created by 金井 慎一 on 2013/10/25.
//  Copyright (c) 2013年 Twelve Axis. All rights reserved.
//

#import "TAXLabelCell.h"

@implementation TAXLabelCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        label.backgroundColor = [UIColor clearColor];
        _textLabel = label;
        [self.contentView addSubview:label];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

# pragma mark - Handler Methods

- (void)capital:(id)sender
{
    UIView *view = self;
    do {
        view = view.superview;
    } while (![view isKindOfClass:[UICollectionView class]]);
    UICollectionView *collectionView = (UICollectionView *)view;
    NSIndexPath *indexPath = [collectionView indexPathForCell:self];
    if ([collectionView.delegate respondsToSelector:@selector(collectionView:performAction:forItemAtIndexPath:withSender:)]) {
        [collectionView.delegate collectionView:collectionView performAction:_cmd forItemAtIndexPath:indexPath withSender:sender];
    }
}

- (void)deleteRow:(id)sender
{
    UIView *view = self;
    do {
        view = view.superview;
    } while (![view isKindOfClass:[UICollectionView class]]);
    UICollectionView *collectionView = (UICollectionView *)view;
    NSIndexPath *indexPath = [collectionView indexPathForCell:self];
    if ([collectionView.delegate respondsToSelector:@selector(collectionView:performAction:forItemAtIndexPath:withSender:)]) {
        [collectionView.delegate collectionView:collectionView performAction:_cmd forItemAtIndexPath:indexPath withSender:sender];
    }
}

@end
