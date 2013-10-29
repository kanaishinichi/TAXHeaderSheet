//
//  TAXHeaderSheetCell.m
//  TAXHeaderSheetDemo
//
//  Created by 金井 慎一 on 2013/10/29.
//  Copyright (c) 2013年 Twelve Axis. All rights reserved.
//

#import "TAXHeaderSheetCell.h"
#import "TAXSpreadSheet.h"

@interface TAXHeaderSheetCell () <TAXSpreadSheetDataSource, TAXSpreadSheetDelegate>
@property (nonatomic, strong) TAXSpreadSheet *spreadSheet;
@end

@implementation TAXHeaderSheetCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        TAXSpreadSheet *spreadSheet = [[TAXSpreadSheet alloc] initWithFrame:self.bounds];
        spreadSheet.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        spreadSheet.dataSource = self;
        spreadSheet.delegate = self;
        _spreadSheet = spreadSheet;
        [self.contentView addSubview:spreadSheet];
    }
    return self;
}

#pragma mark - TAXSpreadSheet DataSource

- (NSUInteger)numberOfRowsInSpreadSheet:(TAXSpreadSheet *)spreadSheet
{
    return [_dataSource numberOfRowsInHeaderSheetCell:self];
}

- (NSUInteger)numberOfColumnsInSpreadSheet:(TAXSpreadSheet *)spreadSheet
{
    return [_dataSource numberOfColumnsInHeaderSheetCell:self];
}

- (UICollectionViewCell *)spreadSheet:(TAXSpreadSheet *)spreadSheet cellAtRow:(NSUInteger)row column:(NSUInteger)column
{
    return [_dataSource headerSheetCell:self cellAtRow:row column:column];
}

#pragma mark - TAXSpreadSheet Delegate

- (CGFloat)spreadSheet:(TAXSpreadSheet *)spreadSheet heightAtRow:(NSUInteger)row
{
    return [_delegate headerSheetCell:self heightAtRow:row];
}

- (CGFloat)spreadSheet:(TAXSpreadSheet *)spreadSheet widthAtColumn:(NSUInteger)column
{
    return [_delegate headerSheetCell:self widthAtColumn:column];
}

- (CGFloat)spreadSheet:(TAXSpreadSheet *)spreadSheet bottomSpacingBelowRow:(NSUInteger)row
{
    return [_delegate headerSheetCell:self bottomSpacingBelowRow:row];
}

- (CGFloat)spreadSheet:(TAXSpreadSheet *)spreadSheet trailingSpacingAfterColumn:(NSUInteger)column
{
    return [_delegate headerSheetCell:self trailingSpacingAfterColumn:column];
}

- (UICollectionReusableView *)spreadSheet:(TAXSpreadSheet *)spreadSheet interRowViewBelowRow:(NSUInteger)row
{
    return [_delegate headerSheetCell:self interRowViewBelowRow:row];
}

- (UICollectionReusableView *)spreadSheet:(TAXSpreadSheet *)spreadSheet interColumnViewAfterColumn:(NSUInteger)column
{
    return [_delegate headerSheetCell:self interColumnViewAfterColumn:column];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_delegate scrollViewDidScroll:scrollView];
}
@end
