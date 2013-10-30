//
//  TAXheaderSheet.m
//  InfusionTable
//
//  Created by 金井 慎一 on 2013/07/30.
//  Copyright (c) 2013年 Twelve Axis. All rights reserved.
//

#import "TAXHeaderSheet.h"
#import "TAXSpreadSheet.h"

@interface TAXHeaderSheet () <TAXSpreadSheetDataSource, TAXSpreadSheetDelegate>

@property (nonatomic) TAXSpreadSheet *containerSheet;
@property (nonatomic) NSMutableArray *sheetArray, *separatorArray, *classArray, *nibArray;

@end

@implementation TAXHeaderSheet

static NSString * const EmptyViewIdentifier = @"EmptyView";
static NSString * const CellIdentifier = @"Cell";

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self p_setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self p_setup];
}

#pragma mark - Private methods

- (void)p_setup
{
    self.backgroundColor = [UIColor redColor];
    self.sheetArray = [NSMutableArray arrayWithCapacity:9];
    self.separatorArray = [NSMutableArray arrayWithCapacity:4];
    self.classArray = [NSMutableArray arrayWithCapacity:9];
    self.nibArray = [NSMutableArray arrayWithCapacity:9];
    
    // Make empty arrays.
    for (NSInteger idx = 0; idx < 9; idx ++) {
        _sheetArray[idx] = [NSNull null];
        _classArray[idx] = [NSMutableArray array];
        _nibArray[idx] = [NSMutableArray array];
    }
    
    for (NSInteger idx = 0; idx < 4; idx ++) {
        _separatorArray[idx] = [NSNull null];
    }
    
    TAXSpreadSheet *containerSheet = [[TAXSpreadSheet alloc] initWithFrame:self.bounds];
    containerSheet.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    containerSheet.backgroundColor = [UIColor lightGrayColor];
    
    [containerSheet registerClass:[TAXSpreadSheet class] forCellWithReuseIdentifier:CellIdentifier];
    [containerSheet registerClass:[UICollectionReusableView class] forInterColumnViewWithReuseIdentifier:EmptyViewIdentifier];
    [containerSheet registerClass:[UICollectionReusableView class] forInterRowViewWithReuseIdentifier:EmptyViewIdentifier];

    containerSheet.scrollEnabled = NO;
    containerSheet.dataSource = self;
    containerSheet.delegate = self;
    
    self.containerSheet = containerSheet;
    [self addSubview:containerSheet];
    
    // Default Size
    self.heightOfHeader = 100.0;
    self.heightOfFooter = 100.0;
    self.widthOfHeader = 100.0;
    self.widthOfFooter = 100.0;
    
    self.heightOfSeparatorTop = 0.0;
    self.heightOfSeparatorBottom = 0.0;
    self.widthOfSeparatorLeft = 0.0;
    self.widthOfSeparatorRight = 0.0;
    
    self.sizeForCell = CGSizeMake(50.0, 50.0);
    self.widthOfHeaderCell = 100.0;
    self.widthOfFooterCell = 100.0;
    self.heightOfHeaderCell = 50.0;
    self.heightOfFooterCell = 50.0;
}

- (TAXHeaderSheetSectionType)p_sectionTypeForColumn:(NSUInteger)column row:(NSUInteger)row
{
    switch (row) {
        case 0:{
            switch (column) {
                case 0:
                    return TAXHeaderSheetSectionTypeTopLeft;
                    break;
                case 1:
                    return TAXHeaderSheetSectionTypeTopMiddle;
                    break;
                case 2:
                    return TAXHeaderSheetSectionTypeTopRight;
                default:
                    break;
            }
        }
            break;
        case 1:{
            switch (column) {
                case 0:
                    return TAXHeaderSheetSectionTypeMiddleLeft;
                    break;
                case 1:
                    return TAXHeaderSheetSectionTypeBody;
                    break;
                case 2:
                    return TAXHeaderSheetSectionTypeMiddleRight;
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:{
            switch (column) {
                case 0:
                    return TAXHeaderSheetSectionTypeBottomLeft;
                    break;
                case 1:
                    return TAXHeaderSheetSectionTypeBottomMiddle;
                    break;
                case 2:
                    return TAXHeaderSheetSectionTypeBottomRight;
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
    return NSNotFound;
}

- (TAXHeaderSheetSectionType)p_sectionTypeForSpreadSheet:(TAXSpreadSheet*)spreadSheet
{
    NSIndexPath *indexPath = [_containerSheet indexPathForCell:spreadSheet];
    TAXHeaderSheetSectionType sectionType = [self p_sectionTypeForColumn:indexPath.item row:indexPath.section];
    return sectionType;
}

- (TAXSpreadSheet *)p_spreadSheetForSectionType:(TAXHeaderSheetSectionType)sectionType
{
    if ([_sheetArray[sectionType] isEqual:[NSNull null]]) {
        return nil;
    } else {
        return _sheetArray[sectionType];
    }
}

#pragma mark

- (UIView *)viewForSectionType:(TAXHeaderSheetSectionType)sectionType
{
    return (UIView*)[self p_spreadSheetForSectionType:sectionType];
}

- (UIView *)viewForSeparatorType:(TAXHeaderSheetSeparatorType)separatorType
{
    if ([_separatorArray[separatorType] isEqual:[NSNull null]]) {
        return nil;
    } else {
        return (UIView *)_separatorArray[separatorType];
    }
}

#pragma mark - SpreadSheet DataSource

- (NSUInteger)numberOfRowsInSpreadSheet:(TAXSpreadSheet *)spreadSheet
{
    if (spreadSheet == _containerSheet) {
        return 3;
    } else {
        NSIndexPath *indexPath = [_containerSheet indexPathForCell:spreadSheet];
        NSUInteger row = indexPath.section;
        switch (row) {
            case 0:
                return self.numberOfRowsOfHeader;
                break;
            case 1:
                return self.numberOfRowsOfBody;
                break;
            case 2:
                return self.numberOfRowsOfFooter;
                break;
            default:
                return 0;
                break;
        }
    }
}

- (NSUInteger)numberOfColumnsInSpreadSheet:(TAXSpreadSheet *)spreadSheet
{
    if (spreadSheet == _containerSheet) {
        return 3;
    } else {
        NSIndexPath *indexPath = [_containerSheet indexPathForCell:spreadSheet];
        NSUInteger column = indexPath.item;
        switch (column) {
            case 0:
                return self.numberOfColumnsOfHeader;
                break;
            case 1:
                return self.numberOfColumnsOfBody;
                break;
            case 2:
                return self.numberOfColumnsOfFooter;
                break;
            default:
                return 0;
                break;
        }
    }
}

- (UICollectionViewCell*)spreadSheet:(TAXSpreadSheet *)spreadSheet cellAtRow:(NSUInteger)row column:(NSUInteger)column
{
    if (spreadSheet == _containerSheet) {
        // Return spreadsheet of section
        
        TAXHeaderSheetSectionType sectionType = [self p_sectionTypeForColumn:column row:row];
        TAXSpreadSheet *spreadSheet = [_containerSheet dequeueReusableCellWithReuseIdentifier:CellIdentifier forRow:row column:column];
        
        if ([_sheetArray[sectionType] isEqual:[NSNull null]]) {
            _sheetArray[sectionType] = spreadSheet;
            
            [spreadSheet registerClass:[UICollectionReusableView class] forInterColumnViewWithReuseIdentifier:EmptyViewIdentifier];
            [spreadSheet registerClass:[UICollectionReusableView class] forInterRowViewWithReuseIdentifier:EmptyViewIdentifier];
            
            // Register class/nib by referring to array.
            for (NSDictionary *dict in _classArray[sectionType]) {
                for (NSString *identifier in [dict allKeys]) {
                    [spreadSheet registerClass:dict[identifier] forCellWithReuseIdentifier:identifier];
                }
            }

            for (NSDictionary *dict in _nibArray[sectionType]) {
                for (NSString *identifier in [dict allKeys]) {
                    [spreadSheet registerNib:dict[identifier] forCellWithReuseIdentifier:identifier];
                }
            }

            spreadSheet.dataSource = self;
            spreadSheet.delegate = self;
            if (sectionType != TAXHeaderSheetSectionTypeBody) {
                spreadSheet.showsHorizontalScrollIndicator = NO;
                spreadSheet.showsVerticalScrollIndicator = NO;
                spreadSheet.scrollEnabled = NO;
            }
        }
        return spreadSheet;
    } else {
        TAXHeaderSheetSectionType sectionType = [self p_sectionTypeForSpreadSheet:spreadSheet];
        return [self.dataSource headerSheet:self cellAtRow:row column:column inSectionType:sectionType];
    }
}

- (UICollectionReusableView *)spreadSheet:(TAXSpreadSheet *)spreadSheet interColumnViewAfterColumn:(NSUInteger)column
{
    if ([spreadSheet isEqual:_containerSheet]) {
        if ([self.delegate respondsToSelector:@selector(headerSheet:separatorViewOfSeparatorType:)]) {
            TAXHeaderSheetSeparatorType separatorType;
            switch (column) {
                case 0:
                    separatorType = TAXHeaderSheetSeparatorTypeLeft;
                    break;
                case 1:
                default:
                    separatorType = TAXHeaderSheetSeparatorTypeRight;
                    break;
            }
            UICollectionReusableView *separatorView = [self.delegate headerSheet:self separatorViewOfSeparatorType:separatorType];
            if (separatorView) {
                _separatorArray[separatorType] = separatorView;
            }
            return separatorView;
        };
    } else {
        if ([self.dataSource respondsToSelector:@selector(headerSheet:interColumnViewInSectionType:afterColumn:)]) {
            TAXHeaderSheetSectionType sectionType = [self p_sectionTypeForSpreadSheet:spreadSheet];
            return [self.delegate headerSheet:self interColumnViewInSectionType:sectionType afterColumn:column];
        };
    }
    return [spreadSheet dequeueReusableInterColumnViewWithIdentifier:EmptyViewIdentifier afterColumn:column];
}

- (UICollectionReusableView *)spreadSheet:(TAXSpreadSheet *)spreadSheet interRowViewBelowRow:(NSUInteger)row
{
    if ([spreadSheet isEqual:_containerSheet]) {
        if ([self.delegate respondsToSelector:@selector(headerSheet:separatorViewOfSeparatorType:)]) {
            TAXHeaderSheetSeparatorType separatorType = TAXHeaderSheetSeparatorTypeTop;
            switch (row) {
                case 0:
                    separatorType = TAXHeaderSheetSeparatorTypeTop;
                    break;
                case 1:
                    separatorType = TAXHeaderSheetSeparatorTypeBottom;
                    break;
                default:
                    break;
            }
            UICollectionReusableView *separatorView = [self.delegate headerSheet:self separatorViewOfSeparatorType:separatorType];
            if (separatorView) {
                _separatorArray[separatorType] = separatorView;
            }
            return separatorView;
        };
    } else {
        if ([self.dataSource respondsToSelector:@selector(headerSheet:interRowViewInSectionType:belowRow:)]) {
            TAXHeaderSheetSectionType sectionType = [self p_sectionTypeForSpreadSheet:spreadSheet];
            return [self.delegate headerSheet:self interRowViewInSectionType:sectionType belowRow:row];
        };
    }
    return [spreadSheet dequeueReusableInterRowViewWithIdentifier:EmptyViewIdentifier belowRow:row];
}

- (CGFloat)spreadSheet:(TAXSpreadSheet *)spreadSheet bottomSpacingBelowRow:(NSUInteger)row
{
    if (spreadSheet == _containerSheet) {
        if (row == 0) {
            return _heightOfSeparatorTop;
        } else {
            return _heightOfSeparatorBottom;
        }
    } else if ([_delegate respondsToSelector:@selector(headerSheet:bottomSpacingBelowRow:inSectionType:)]) {
        TAXHeaderSheetSectionType sectionType = [self p_sectionTypeForSpreadSheet:spreadSheet];
        return [_delegate headerSheet:self bottomSpacingBelowRow:row inSectionType:sectionType];
    } else return 0.0;
}

- (CGFloat)spreadSheet:(TAXSpreadSheet *)spreadSheet trailingSpacingAfterColumn:(NSUInteger)column
{
    if (spreadSheet == _containerSheet) {
        if (column == 0) {
            return _widthOfSeparatorLeft;
        } else {
            return _widthOfSeparatorRight;
        }
    } else if ([_delegate respondsToSelector:@selector(headerSheet:trailingSpacingAfterColumn:inSectionType:)]) {
        TAXHeaderSheetSectionType sectionType = [self p_sectionTypeForSpreadSheet:spreadSheet];
        return [_delegate headerSheet:self trailingSpacingAfterColumn:column inSectionType:sectionType];
    } else return 0.0;
}

# pragma mark - SpreadSheet Delegate

- (CGFloat)spreadSheet:(TAXSpreadSheet *)spreadSheet widthAtColumn:(NSUInteger)column
{
    if ([spreadSheet isEqual:_containerSheet]) {
        if (column == 0) {
            return _widthOfHeader;
        } else if (column == 1) {
            return self.bounds.size.width - _widthOfHeader - _widthOfFooter - _widthOfSeparatorLeft - _widthOfSeparatorRight;
        } else {
            return _widthOfFooter;
        }
    } else {
        // Return width with priority (Top > Bottom > Middle > Property)
        TAXHeaderSheetSectionType sectionType = [self p_sectionTypeForSpreadSheet:spreadSheet];
        if ([self.delegate respondsToSelector:@selector(headerSheet:widthAtColumn:ofSectionType:)]) {
            switch (sectionType) {
                    case TAXHeaderSheetSectionTypeTopLeft:
                    case TAXHeaderSheetSectionTypeMiddleLeft:
                    case TAXHeaderSheetSectionTypeBottomLeft:{
                        CGFloat topLeft = [_delegate headerSheet:self widthAtColumn:column ofSectionType:TAXHeaderSheetSectionTypeTopLeft];
                        CGFloat middleLeft = [_delegate headerSheet:self widthAtColumn:column ofSectionType:TAXHeaderSheetSectionTypeMiddleLeft];
                        CGFloat bottomLeft = [_delegate headerSheet:self widthAtColumn:column ofSectionType:TAXHeaderSheetSectionTypeBottomLeft];

                        if (topLeft != NSNotFound) {
                            return topLeft;
                        } else if (bottomLeft != NSNotFound) {
                            return bottomLeft;
                        } else if (middleLeft != NSNotFound) {
                            return middleLeft;
                        } else return _widthOfHeaderCell;
                    }
                    case TAXHeaderSheetSectionTypeTopMiddle:
                    case TAXHeaderSheetSectionTypeBody:
                    case TAXHeaderSheetSectionTypeBottomMiddle:{
                        CGFloat topMiddle = [_delegate headerSheet:self widthAtColumn:column ofSectionType:TAXHeaderSheetSectionTypeTopMiddle];
                        CGFloat body = [_delegate headerSheet:self widthAtColumn:column ofSectionType:TAXHeaderSheetSectionTypeBody];
                        CGFloat bottomMiddle = [_delegate headerSheet:self widthAtColumn:column ofSectionType:TAXHeaderSheetSectionTypeBottomMiddle];
                        
                        if (topMiddle != NSNotFound) {
                            return topMiddle;
                        } else if (bottomMiddle != NSNotFound) {
                            return bottomMiddle;
                        } else if (body != NSNotFound) {
                            return body;
                        } else return _sizeForCell.width;
                    }
                    case TAXHeaderSheetSectionTypeTopRight:
                    case TAXHeaderSheetSectionTypeMiddleRight:
                    case TAXHeaderSheetSectionTypeBottomRight:{
                        CGFloat topRight = [_delegate headerSheet:self widthAtColumn:column ofSectionType:TAXHeaderSheetSectionTypeTopRight];
                        CGFloat middleRight = [_delegate headerSheet:self widthAtColumn:column ofSectionType:TAXHeaderSheetSectionTypeMiddleRight];
                        CGFloat bottomRight = [_delegate headerSheet:self widthAtColumn:column ofSectionType:TAXHeaderSheetSectionTypeBottomRight];
                        
                        if (topRight != NSNotFound) {
                            return topRight;
                        } else if (bottomRight != NSNotFound) {
                            return bottomRight;
                        } else if (middleRight != NSNotFound) {
                            return middleRight;
                        } else return _widthOfFooterCell;
                    }
                default:
                    break;
            }
        } else {
            if (sectionType == TAXHeaderSheetSectionTypeTopLeft ||
                sectionType == TAXHeaderSheetSectionTypeMiddleLeft ||
                sectionType == TAXHeaderSheetSectionTypeBottomLeft) {
                return self.widthOfHeaderCell;
            } else if (sectionType == TAXHeaderSheetSectionTypeTopMiddle ||
                       sectionType == TAXHeaderSheetSectionTypeBody ||
                       sectionType == TAXHeaderSheetSectionTypeBottomMiddle) {
                return self.sizeForCell.width;
            } else {
                return self.widthOfFooterCell;
            }
        }
    }
}

- (CGFloat)spreadSheet:(TAXSpreadSheet *)spreadSheet heightAtRow:(NSUInteger)row
{
    if ([spreadSheet isEqual:_containerSheet]) {
        if (row == 0) {
            return self.heightOfHeader;
        } else if (row == 1) {
            return self.bounds.size.height - self.heightOfHeader - self.heightOfFooter - self.heightOfSeparatorTop - self.heightOfSeparatorBottom;
        } else {
            return self.heightOfFooter;
        }
    } else {
        // Return height with priority (Left > Right > Middle > Property)
        TAXHeaderSheetSectionType sectionType = [self p_sectionTypeForSpreadSheet:spreadSheet];
        if ([self.delegate respondsToSelector:@selector(headerSheet:heightAtRow:ofSectionType:)]) {
            switch (sectionType) {
                    case TAXHeaderSheetSectionTypeTopLeft:
                    case TAXHeaderSheetSectionTypeTopMiddle:
                    case TAXHeaderSheetSectionTypeTopRight:{
                        CGFloat topLeft = [_delegate headerSheet:self heightAtRow:row ofSectionType:TAXHeaderSheetSectionTypeTopLeft];
                        CGFloat topMiddle = [_delegate headerSheet:self heightAtRow:row ofSectionType:TAXHeaderSheetSectionTypeTopMiddle];
                        CGFloat topRight = [_delegate headerSheet:self heightAtRow:row ofSectionType:TAXHeaderSheetSectionTypeTopRight];
                        
                        if (topLeft != NSNotFound) {
                            return topLeft;
                        } else if (topMiddle != NSNotFound) {
                            return topMiddle;
                        } else if (topRight != NSNotFound) {
                            return topRight;
                        } else return _heightOfHeaderCell;
                    }
                    case TAXHeaderSheetSectionTypeMiddleLeft:
                    case TAXHeaderSheetSectionTypeBody:
                    case TAXHeaderSheetSectionTypeMiddleRight:{
                        CGFloat middleLeft = [_delegate headerSheet:self heightAtRow:row ofSectionType:TAXHeaderSheetSectionTypeMiddleLeft];
                        CGFloat body = [_delegate headerSheet:self heightAtRow:row ofSectionType:TAXHeaderSheetSectionTypeBody];
                        CGFloat middleRight = [_delegate headerSheet:self heightAtRow:row ofSectionType:TAXHeaderSheetSectionTypeMiddleRight];
                        
                        if (middleLeft != NSNotFound) {
                            return middleLeft;
                        } else if (body != NSNotFound) {
                            return body;
                        } else if (middleRight != NSNotFound) {
                            return middleRight;
                        } else return _sizeForCell.height;
                    }
                    case TAXHeaderSheetSectionTypeBottomLeft:
                    case TAXHeaderSheetSectionTypeBottomMiddle:
                    case TAXHeaderSheetSectionTypeBottomRight:{
                        CGFloat bottomLeft = [_delegate headerSheet:self heightAtRow:row ofSectionType:TAXHeaderSheetSectionTypeBottomLeft];
                        CGFloat bottomMiddle = [_delegate headerSheet:self heightAtRow:row ofSectionType:TAXHeaderSheetSectionTypeBottomMiddle];
                        CGFloat bottomRight = [_delegate headerSheet:self heightAtRow:row ofSectionType:TAXHeaderSheetSectionTypeBottomRight];
                        
                        if (bottomLeft != NSNotFound) {
                            return bottomLeft;
                        } else if (bottomMiddle != NSNotFound) {
                            return bottomMiddle;
                        } else if (bottomRight != NSNotFound) {
                            return bottomRight;
                        } else return _heightOfFooterCell;
                    }
                default:
                    break;
            }
        } else {
            if (sectionType == TAXHeaderSheetSectionTypeTopLeft ||
                sectionType == TAXHeaderSheetSectionTypeTopMiddle ||
                sectionType == TAXHeaderSheetSectionTypeTopRight) {
                return self.heightOfHeaderCell;
            } else if (sectionType == TAXHeaderSheetSectionTypeMiddleLeft ||
                       sectionType == TAXHeaderSheetSectionTypeBody ||
                       sectionType == TAXHeaderSheetSectionTypeMiddleRight) {
                return self.sizeForCell.height;
            } else {
                return self.heightOfFooterCell;
            }
        }
    }
}

# pragma mark - ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    TAXSpreadSheet *spreadSheet = (TAXSpreadSheet *)scrollView.superview;
    TAXHeaderSheetSectionType sectionType = [self p_sectionTypeForSpreadSheet:spreadSheet];
    if (sectionType == TAXHeaderSheetSectionTypeBody) {
        CGPoint scrollingOffset = scrollView.contentOffset;
        [[self p_spreadSheetForSectionType:TAXHeaderSheetSectionTypeTopMiddle] setContentOffset:CGPointMake(scrollingOffset.x, 0)];
        [[self p_spreadSheetForSectionType:TAXHeaderSheetSectionTypeBottomMiddle] setContentOffset:CGPointMake(scrollingOffset.x, 0)];
        [[self p_spreadSheetForSectionType:TAXHeaderSheetSectionTypeMiddleLeft] setContentOffset:CGPointMake(0, scrollingOffset.y)];
        [[self p_spreadSheetForSectionType:TAXHeaderSheetSectionTypeMiddleRight] setContentOffset:CGPointMake(0, scrollingOffset.y)];
    }
}

# pragma mark - Register class for separator views of container sheet

- (void)registerClass:(Class)viewClass forSeparatorViewWithReuseIdentifier:(NSString *)identifier
{
    [_containerSheet registerClass:viewClass forInterRowViewWithReuseIdentifier:identifier];
    [_containerSheet registerClass:viewClass forInterColumnViewWithReuseIdentifier:identifier];
}

- (void)registerNib:(UINib *)nib forSeparatorViewWithReuseIdentifier:(NSString *)identifier
{
    [_containerSheet registerNib:nib forInterRowViewWithReuseIdentifier:identifier];
    [_containerSheet registerNib:nib forInterColumnViewWithReuseIdentifier:identifier];
}

- (void)registerClass:(Class)viewClass forSeparatorViewOfSeparatorType:(TAXHeaderSheetSeparatorType)separatorType withReuseIdentifier:(NSString *)identifier
{
    if (separatorType == TAXHeaderSheetSeparatorTypeTop ||
        separatorType == TAXHeaderSheetSeparatorTypeBottom) {
        [_containerSheet registerClass:viewClass forInterRowViewWithReuseIdentifier:identifier];
    } else {
        [_containerSheet registerClass:viewClass forInterColumnViewWithReuseIdentifier:identifier];
    }
}

- (void)registerNib:(UINib *)nib forSeparatorViewOfSeparatorType:(TAXHeaderSheetSeparatorType)separatorType withReuseIdentifier:(NSString *)identifier
{
    if (separatorType == TAXHeaderSheetSeparatorTypeTop ||
        separatorType == TAXHeaderSheetSeparatorTypeBottom) {
        [_containerSheet registerNib:nib forInterRowViewWithReuseIdentifier:identifier];
    } else {
        [_containerSheet registerNib:nib forInterColumnViewWithReuseIdentifier:identifier];
    }
}

#pragma mark Dequeue Separator Views

- (id)dequeueReusableSeparatorViewOfSeparatorType:(TAXHeaderSheetSeparatorType)separatorType withReuseIdentifier:(NSString *)identifier
{
    switch (separatorType) {
        case TAXHeaderSheetSeparatorTypeTop:
            return [_containerSheet dequeueReusableInterRowViewWithIdentifier:identifier belowRow:0];
            break;
        case TAXHeaderSheetSeparatorTypeBottom:
            return [_containerSheet dequeueReusableInterRowViewWithIdentifier:identifier belowRow:1];
            break;
        case TAXHeaderSheetSeparatorTypeLeft:
            return [_containerSheet dequeueReusableInterColumnViewWithIdentifier:identifier afterColumn:0];
            break;
        case TAXHeaderSheetSeparatorTypeRight:
            return [_containerSheet dequeueReusableInterColumnViewWithIdentifier:identifier afterColumn:1];
            break;
        default:
            return nil;
            break;
    }
}

#pragma mark - Register Class/Nib for each sheet

// Register Class/Nib to NSDictionary whose key is identifier and value is class/nib.

#pragma mark Cell

- (void)registerClass:(Class)cellClass forCellInSectionType:(TAXHeaderSheetSectionType)sectionType withReuseIdentifier:(NSString *)identifier
{
    [_classArray[sectionType] addObject:@{identifier: cellClass}];
}

- (void)registerClass:(Class)cellClass forCellInAllSectionWithReuseIdentifier:(NSString *)identifier
{
    for (TAXHeaderSheetSectionType sectionType = TAXHeaderSheetSectionTypeBody; sectionType <= TAXHeaderSheetSectionTypeBottomRight; sectionType++) {
        [_classArray[sectionType] addObject:@{identifier: cellClass}];
    }
}

- (void)registerNib:(UINib *)nib forCellInSectionType:(TAXHeaderSheetSectionType)sectionType withReuseIdentifier:(NSString *)identifier
{
    [_nibArray[sectionType] addObject:@{identifier: nib}];
}

- (void)registerNib:(UINib *)nib forCellInAllSectionWithReuseIdentifier:(NSString *)identifier
{
    for (TAXHeaderSheetSectionType sectionType = TAXHeaderSheetSectionTypeBody; sectionType <= TAXHeaderSheetSectionTypeBottomRight; sectionType++) {
        [_nibArray[sectionType] addObject:@{identifier: nib}];
    }
}

#pragma mark Inter column view

- (void)registerClass:(Class)viewClass forInterColumnViewInSectionType:(TAXHeaderSheetSectionType)sectionType withReuseIdentifier:(NSString *)identifier
{
    [_classArray[sectionType] addObject:@{identifier: viewClass}];
}

- (void)registerNib:(UINib *)nib forInterColumnViewInSectionType:(TAXHeaderSheetSectionType)sectionType withReuseIdentifier:(NSString *)identifier
{
    [_nibArray[sectionType] addObject:@{identifier: nib}];
}

#pragma mark Inter row view

- (void)registerClass:(Class)viewClass forInterRowViewInSectionType:(TAXHeaderSheetSectionType)sectionType withReuseIdentifier:(NSString *)identifier
{
    [_classArray[sectionType] addObject:@{identifier: viewClass}];
}

- (void)registerNib:(UINib *)nib forInterRowViewInSectionType:(TAXHeaderSheetSectionType)sectionType withReuseIdentifier:(NSString *)identifier
{
    [_nibArray[sectionType] addObject:@{identifier: nib}];
}

#pragma mark - Dequeue Cells/Views from each sheet

- (id)dequeueReusableCellInSectionType:(TAXHeaderSheetSectionType)sectionType withReuseIdentifier:(NSString *)identifier forRow:(NSUInteger)row column:(NSUInteger)column
{
    TAXSpreadSheet *spreadSheet = _sheetArray[sectionType];
    UICollectionViewCell *cell = [spreadSheet dequeueReusableCellWithReuseIdentifier:identifier forRow:row column:column];
    return cell;
}

- (id)dequeueReusableInterColumnViewInSectionType:(TAXHeaderSheetSectionType)sectionType withReuseIdentifier:(NSString *)identifier afterColumn:(NSUInteger)column
{
    TAXSpreadSheet *spreadSheet = _sheetArray[sectionType];
    return [spreadSheet dequeueReusableInterColumnViewWithIdentifier:identifier afterColumn:column];
}

- (id)dequeueReusableInterRowViewInSectionType:(TAXHeaderSheetSectionType)sectionType withReuseIdentifier:(NSString *)identifier belowRow:(NSUInteger)row
{
    TAXSpreadSheet *spreadSheet = _sheetArray[sectionType];
    return [spreadSheet dequeueReusableInterRowViewWithIdentifier:identifier belowRow:row];
}

# pragma mark -

- (NSIndexPath *)indexPathForCell:(UICollectionViewCell *)cell inSectionType:(TAXHeaderSheetSectionType)sectionType
{
    TAXSpreadSheet *spreadSheet = [self p_spreadSheetForSectionType:sectionType];
    return [spreadSheet indexPathForCell:cell];
}

@end
