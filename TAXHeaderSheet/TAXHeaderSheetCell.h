//
//  TAXHeaderSheetCell.h
//  TAXHeaderSheetDemo
//
//  Created by 金井 慎一 on 2013/10/29.
//  Copyright (c) 2013年 Twelve Axis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TAXHeaderSheetCell;

@protocol TAXHeaderSheetCellDataSource <NSObject>
@required
// Getting spreadsheet metrics.
- (NSUInteger)numberOfRowsInHeaderSheetCell:(TAXHeaderSheetCell *)headerSheetCell;
- (NSUInteger)numberOfColumnsInHeaderSheetCell:(TAXHeaderSheetCell *)headerSheetCell;

// Getting views for cells.
- (UICollectionViewCell*)headerSheetCell:(TAXHeaderSheetCell *)headerSheetCell cellAtRow:(NSUInteger)row column:(NSUInteger)column ;
@end

@protocol TAXHeaderSheetCellDelegate <UICollectionViewDelegate>
@optional
// Specifying individual cell heights/widths and spacing.
// In case of using default value, return NSNotFound.
- (CGFloat)headerSheetCell:(TAXHeaderSheetCell *)headerSheetCell heightAtRow:(NSUInteger)row;
- (CGFloat)headerSheetCell:(TAXHeaderSheetCell *)headerSheetCell widthAtColumn:(NSUInteger)column;

- (CGFloat)headerSheetCell:(TAXHeaderSheetCell *)headerSheetCell bottomSpacingBelowRow:(NSUInteger)row;
- (CGFloat)headerSheetCell:(TAXHeaderSheetCell *)headerSheetCell trailingSpacingAfterColumn:(NSUInteger)column;

- (UICollectionReusableView *)headerSheetCell:(TAXHeaderSheetCell *)headerSheetCell interRowViewBelowRow:(NSUInteger)row;
- (UICollectionReusableView *)headerSheetCell:(TAXHeaderSheetCell *)spreadSheet interColumnViewAfterColumn:(NSUInteger)column;

@end

@interface TAXHeaderSheetCell : UICollectionViewCell
@property (nonatomic, weak) id <TAXHeaderSheetCellDataSource> dataSource;
@property (nonatomic, weak) id <TAXHeaderSheetCellDelegate> delegate;
@end
