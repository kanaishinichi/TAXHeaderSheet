//
//  TAXheaderSheet.h
//  InfusionTable
//
//  Created by 金井 慎一 on 2013/07/30.
//  Copyright (c) 2013年 Twelve Axis. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TAXHeaderSheetSectionType)
{
    TAXHeaderSheetSectionTypeBody,
    TAXHeaderSheetSectionTypeTopLeft,
    TAXHeaderSheetSectionTypeTopMiddle,
    TAXHeaderSheetSectionTypeTopRight,
    TAXHeaderSheetSectionTypeMiddleLeft,
    TAXHeaderSheetSectionTypeMiddleRight,
    TAXHeaderSheetSectionTypeBottomLeft,
    TAXHeaderSheetSectionTypeBottomMiddle,
    TAXHeaderSheetSectionTypeBottomRight
};

typedef NS_ENUM(NSInteger, TAXHeaderSheetSeparatorType)
{
    TAXHeaderSheetSeparatorTypeTop,
    TAXHeaderSheetSeparatorTypeBottom,
    TAXHeaderSheetSeparatorTypeLeft,
    TAXHeaderSheetSeparatorTypeRight
};

@class TAXHeaderSheet;

#pragma mark - Delegate

@protocol TAXHeaderSheetDelegate <NSObject>

@optional
// Separator Views of container
- (UICollectionReusableView *)headerSheet:(TAXHeaderSheet *)headerSheet separatorViewOfSeparatorType:(TAXHeaderSheetSeparatorType)separatorType;

// Size of cell in each sheet
- (CGFloat)headerSheet:(TAXHeaderSheet *)headerSheet heightAtRow:(NSUInteger)row ofSectionType:(TAXHeaderSheetSectionType)sectionType;
- (CGFloat)headerSheet:(TAXHeaderSheet *)headerSheet widthAtColumn:(NSUInteger)column ofSectionType:(TAXHeaderSheetSectionType)sectionType;

// Inter-column/row spacing of each sheet
- (CGFloat)headerSheet:(TAXHeaderSheet *)headerSheet bottomSpacingBelowRow:(NSUInteger)row inSectionType:(TAXHeaderSheetSectionType)sectionType;
- (CGFloat)headerSheet:(TAXHeaderSheet *)headerSheet trailingSpacingAfterColumn:(NSUInteger)column inSectionType:(TAXHeaderSheetSectionType)sectionType;

// Inter-column/row view of each sheet
- (UICollectionReusableView *)headerSheet:(TAXHeaderSheet *)headerSheet interColumnViewInSectionType:(TAXHeaderSheetSectionType)sectionType afterColumn:(NSUInteger)column;
- (UICollectionReusableView *)headerSheet:(TAXHeaderSheet *)headerSheet interRowViewInSectionType:(TAXHeaderSheetSectionType)sectionType belowRow:(NSUInteger)row;

@end

#pragma mark - DataSource

@protocol TAXHeaderSheetDataSource <NSObject>

- (UICollectionViewCell*)headerSheet:(TAXHeaderSheet *)headerSheet cellAtRow:(NSUInteger)row column:(NSUInteger)column inSectionType:(TAXHeaderSheetSectionType)sectionType;

@end

#pragma mark -

@interface TAXHeaderSheet : UIView

@property (nonatomic, weak) IBOutlet id <TAXHeaderSheetDelegate> delegate;
@property (nonatomic, weak) IBOutlet id <TAXHeaderSheetDataSource> dataSource;

// Size of each section.
@property (nonatomic, assign) CGFloat heightOfHeader, heightOfFooter, widthOfHeader, widthOfFooter;

// Size of separators.
@property (nonatomic, assign) CGFloat heightOfSeparatorTop, heightOfSeparatorBottom, widthOfSeparatorLeft, widthOfSeparatorRight;

// Size of cells in each spreadSheet
@property (nonatomic, assign) CGSize sizeForCell;
@property (nonatomic, assign) CGFloat widthOfHeaderCell, widthOfFooterCell, heightOfHeaderCell, heightOfFooterCell;

// Number of rows/columns of each section.
@property (nonatomic, assign) NSUInteger numberOfRowsOfBody, numberOfColumnsOfBody, numberOfRowsOfHeader, numberOfRowsOfFooter, numberOfColumnsOfHeader, numberOfColumnsOfFooter;

#pragma mark - Separator views

// Register Class for separator views
- (void)registerClass:(Class)viewClass forSeparatorViewOfSeparatorType:(TAXHeaderSheetSeparatorType)separatorType withReuseIdentifier:(NSString *)identifier;
- (void)registerNib:(UINib *)nib forSeparatorViewOfSeparatorType:(TAXHeaderSheetSeparatorType)separatorType withReuseIdentifier:(NSString *)identifier;

// Dequeue form separator views
- (id)dequeueReusableSeparatorViewOfSeparatorType:(TAXHeaderSheetSeparatorType)separatorType withReuseIdentifier:(NSString *)identifier;

#pragma mark - For internal spreadSheets

// Register class for Cells of each section
- (void)registerClass:(Class)cellClass forCellInSectionType:(TAXHeaderSheetSectionType)sectionType withReuseIdentifier:(NSString *)identifier;
- (void)registerNib:(UINib *)nib forCellInSectionType:(TAXHeaderSheetSectionType)sectionType withReuseIdentifier:(NSString *)identifier;

- (void)registerClass:(Class)cellClass forCellInAllSectionWithReuseIdentifier:(NSString *)identifier;
- (void)registerNib:(UINib *)nib forCellInAllSectionWithReuseIdentifier:(NSString *)identifier;

// Register Class for Inter Column View
- (void)registerClass:(Class)viewClass forInterColumnViewInSectionType:(TAXHeaderSheetSectionType)sectionType withReuseIdentifier:(NSString *)identifier;
- (void)registerNib:(UINib *)nib forInterColumnViewInSectionType:(TAXHeaderSheetSectionType)sectionType withReuseIdentifier:(NSString *)identifier;

// Register Class for Inter Row View
- (void)registerClass:(Class)viewClass forInterRowViewInSectionType:(TAXHeaderSheetSectionType)sectionType withReuseIdentifier:(NSString *)identifier;
- (void)registerNib:(UINib *)nib forInterRowViewInSectionType:(TAXHeaderSheetSectionType)sectionType withReuseIdentifier:(NSString *)identifier;

// Dequeue Cells/Views
- (id)dequeueReusableCellInSectionType:(TAXHeaderSheetSectionType)sectionType withReuseIdentifier:(NSString *)identifier forRow:(NSUInteger)row column:(NSUInteger)column;
- (id)dequeueReusableInterColumnViewInSectionType:(TAXHeaderSheetSectionType)sectionType withReuseIdentifier:(NSString *)identifier afterColumn:(NSUInteger)column;
- (id)dequeueReusableInterRowViewInSectionType:(TAXHeaderSheetSectionType)sectionType withReuseIdentifier:(NSString *)identifier belowRow:(NSUInteger)row;

// Return each section/separator as UIView
- (UIView *)viewForSectionType:(TAXHeaderSheetSectionType)sectionType;
- (UIView *)viewForSeparatorType:(TAXHeaderSheetSeparatorType)separatorType;

@end
