//
//  ViewController.m
//  TAXHeaderSheetDemo
//
//  Created by 金井 慎一 on 2013/10/29.
//  Copyright (c) 2013年 Twelve Axis. All rights reserved.
//

#import "ViewController.h"
#import "TAXHeaderSheet.h"
#import "TAXLabelCell.h"

@interface ViewController ()
@property (nonatomic, weak) IBOutlet TAXHeaderSheet *headerSheet;
@property (nonatomic) NSInteger numberOfRowsOfBody, numberOfColumnsOfBody;
@property (nonatomic) NSInteger numberOfRowsOfHeader, numberOfColumnsOfHeader;
@property (nonatomic) NSInteger numberOfRowsOfFooter, numberOfColumnsOfFooter;
- (IBAction)insertRowDidTap:(id)sender;
- (IBAction)moveRowDidTap:(id)sender;
- (IBAction)insertColumnDidTap:(id)sender;
- (IBAction)moveColumnDidTap:(id)sender;
@end

@implementation ViewController

static NSString * const CellIdentifier = @"Cell";
static NSString * const SeparatorIdentifier = @"Separator";

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    // Set spreadsheet metrics.
    self.numberOfRowsOfBody = 30;
    self.numberOfColumnsOfBody = 20;

    self.numberOfRowsOfHeader = 1;
    self.numberOfRowsOfFooter = 2;
    self.numberOfColumnsOfHeader = 1;
    self.numberOfColumnsOfFooter = 1;

    // Set size of cell in each section
    _headerSheet.sizeForCell = CGSizeMake(50.0, 20.0);
    _headerSheet.widthOfHeaderCell = 50.0;
    _headerSheet.widthOfFooterCell = 50.0;
    _headerSheet.heightOfHeaderCell = 20.0;
    _headerSheet.heightOfFooterCell = 20.0;
    
    _headerSheet.heightOfHeader = _headerSheet.heightOfHeaderCell * _numberOfRowsOfHeader;
    _headerSheet.heightOfFooter = _headerSheet.heightOfFooterCell * _numberOfRowsOfFooter;
    _headerSheet.widthOfHeader = _headerSheet.widthOfHeaderCell * _numberOfColumnsOfHeader;
    _headerSheet.widthOfFooter = _headerSheet.widthOfFooterCell * _numberOfColumnsOfFooter;
    
    // Set size of separator
    _headerSheet.heightOfSeparatorTop = 2;
    _headerSheet.heightOfSeparatorBottom = 4;
    _headerSheet.widthOfSeparatorLeft = 1;
    _headerSheet.widthOfSeparatorRight = 1;
    
    // Register class for cells.
    [_headerSheet registerClass:[TAXLabelCell class] forCellInAllSectionWithReuseIdentifier:CellIdentifier];

    // Register class for separator views.
    [_headerSheet registerClass:[UICollectionReusableView class] forSeparatorViewWithReuseIdentifier:SeparatorIdentifier];
}

#pragma mark - HeaderSheet DataSource

- (UICollectionViewCell*)headerSheet:(TAXHeaderSheet *)headerSheet cellAtRow:(NSUInteger)row column:(NSUInteger)column inSectionType:(TAXHeaderSheetSectionType)sectionType
{
    TAXLabelCell *cell = [headerSheet dequeueReusableCellInSectionType:sectionType withReuseIdentifier:CellIdentifier forRow:row column:column];
    
    switch (sectionType) {
            case TAXHeaderSheetSectionTypeBody:
            case TAXHeaderSheetSectionTypeMiddleRight:
            case TAXHeaderSheetSectionTypeBottomMiddle:
            case TAXHeaderSheetSectionTypeBottomRight:{
                cell.textLabel.text = [NSString stringWithFormat:@"%d-%d", row, column];
                cell.backgroundColor = [UIColor whiteColor];
                break;
            }
            case TAXHeaderSheetSectionTypeTopMiddle:
            case TAXHeaderSheetSectionTypeTopRight:{
                cell.textLabel.text = [NSString stringWithFormat:@"Col %d", column];
                cell.backgroundColor = [UIColor darkGrayColor];
                cell.textLabel.textColor = [UIColor lightTextColor];
                break;
            }
            case TAXHeaderSheetSectionTypeMiddleLeft:
            case TAXHeaderSheetSectionTypeBottomLeft:{
                cell.textLabel.text = [NSString stringWithFormat:@"Row %d", row];
                cell.backgroundColor = [UIColor lightGrayColor];
                cell.textLabel.textColor = [UIColor lightTextColor];
                break;
            }
            case TAXHeaderSheetSectionTypeTopLeft:{
                break;
            }
        default:
            break;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:10.0];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (NSInteger)headerSheet:(TAXHeaderSheet *)headerSheet numberOfRowsInHorizontalSectionType:(TAXHeaderSheetHorizontalSectionType)horizontalSectionType
{
    switch (horizontalSectionType) {
        case TAXHeaderSheetHorizontalSectionTypeTop:
            return _numberOfRowsOfHeader;
            break;
        case TAXHeaderSheetHorizontalSectionTypeMiddle:
            return _numberOfRowsOfBody;
            break;
        case TAXHeaderSheetHorizontalSectionTypeBottom:
            return _numberOfRowsOfFooter;
            break;
        default:
            return NSNotFound;
            break;
    }
}

- (NSInteger)headerSheet:(TAXHeaderSheet *)headerSheet numberOfColumnsInVerticalSectionType:(TAXHeaderSheetVerticalSectionType)verticalSectionType
{
    switch (verticalSectionType) {
        case TAXHeaderSheetVerticalSectionTypeLeft:
            return _numberOfColumnsOfHeader;
            break;
        case TAXHeaderSheetVerticalSectionTypeMiddle:
            return _numberOfColumnsOfBody;
            break;
        case TAXHeaderSheetVerticalSectionTypeRight:
            return _numberOfColumnsOfFooter;
            break;
        default:
            return NSNotFound;
            break;
    }
}

# pragma mark - HeaderSheet Delegate

- (CGFloat)headerSheet:(TAXHeaderSheet *)headerSheet bottomSpacingBelowRow:(NSUInteger)row inSectionType:(TAXHeaderSheetSectionType)sectionType
{
    return 1.0;
}
 
- (CGFloat)headerSheet:(TAXHeaderSheet *)headerSheet trailingSpacingAfterColumn:(NSUInteger)column inSectionType:(TAXHeaderSheetSectionType)sectionType
{
    return 1.0;
}

- (UICollectionReusableView *)headerSheet:(TAXHeaderSheet *)headerSheet separatorViewOfSeparatorType:(TAXHeaderSheetSeparatorType)separatorType
{
    UICollectionReusableView *view = [_headerSheet dequeueReusableSeparatorViewOfSeparatorType:separatorType withReuseIdentifier:SeparatorIdentifier];
    
    switch (separatorType) {
        case TAXHeaderSheetSeparatorTypeTop:{
            view.backgroundColor = [UIColor blueColor];
            break;
        }
        case TAXHeaderSheetSeparatorTypeBottom:{
            view.backgroundColor = [UIColor redColor];
            break;
        }
        case TAXHeaderSheetSeparatorTypeRight:{
            view.backgroundColor = [UIColor greenColor];
            break;
        }
        default:
            return nil;
            break;
    }
    return view;
}

- (void)headerSheet:(TAXHeaderSheet *)headerSheet didSelectItemAtIndexPath:(NSIndexPath *)indexPath inSectionType:(TAXHeaderSheetSectionType)sectionType
{
    if (sectionType == TAXHeaderSheetSectionTypeBody) {
        NSString *message = [NSString stringWithFormat:@"Row:%d Column:%d \nhas tapped.", indexPath.section, indexPath.item];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:message delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK", nil];
        [alertView show];
    }
}

# pragma mark Menu

- (BOOL)headerSheet:(TAXHeaderSheet *)headerSheet shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath inSectionType:(TAXHeaderSheetSectionType)sectionType
{
    if (sectionType == TAXHeaderSheetSectionTypeMiddleLeft) {
        UIMenuItem *menuItem = [[UIMenuItem alloc] initWithTitle:@"Delete Row" action:NSSelectorFromString(@"deleteRow:")];
        [[UIMenuController sharedMenuController] setMenuItems:@[menuItem]];
        return YES;
    } else if (sectionType == TAXHeaderSheetSectionTypeTopMiddle) {
        UIMenuItem *menuItem = [[UIMenuItem alloc] initWithTitle:@"Delete Column" action:NSSelectorFromString(@"deleteColumn:")];
        [[UIMenuController sharedMenuController] setMenuItems:@[menuItem]];
        return YES;
    } else return NO;
}

- (BOOL)headerSheet:(TAXHeaderSheet *)headerSheet canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath inSectionType:(TAXHeaderSheetSectionType)sectionType withSender:(id)sender
{
    return (action == NSSelectorFromString(@"deleteRow:") ||
            action == NSSelectorFromString(@"deleteColumn:"));
}

- (void)headerSheet:(TAXHeaderSheet *)headerSheet performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath inSectionType:(TAXHeaderSheetSectionType)sectionType withSender:(id)sender
{
    if (action == NSSelectorFromString(@"deleteRow:")) {
        self.numberOfRowsOfBody -= 1;
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:indexPath.section];
        [_headerSheet deleteRowsAtIndexPaths:indexSet inHorizontalSectionType:TAXHeaderSheetHorizontalSectionTypeMiddle];
    } else if (action == NSSelectorFromString(@"deleteColumn:")) {
        self.numberOfColumnsOfBody -= 1;
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:indexPath.item];
        [_headerSheet deleteColumnsAtIndexPaths:indexSet inVerticalSectionType:TAXHeaderSheetVerticalSectionTypeMiddle];
    }
}

# pragma mark - Handler methods

- (IBAction)insertRowDidTap:(id)sender
{
    self.numberOfRowsOfBody += 1;
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:1];
    [_headerSheet insertRowsAtIndexPaths:indexSet inHorizontalSectionType:TAXHeaderSheetHorizontalSectionTypeMiddle];
}

- (IBAction)moveRowDidTap:(id)sender
{
    [_headerSheet moveRow:5 toRow:2 inHorizontalSectionType:TAXHeaderSheetHorizontalSectionTypeMiddle];
}

- (IBAction)insertColumnDidTap:(id)sender
{
    self.numberOfColumnsOfBody += 1;
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:1];
    [_headerSheet insertColumnsAtIndexPaths:indexSet inVerticalSectionType:TAXHeaderSheetVerticalSectionTypeMiddle];
}

- (IBAction)moveColumnDidTap:(id)sender
{
    [_headerSheet moveColumn:5 toColumn:2 inVerticalSectionType:TAXHeaderSheetVerticalSectionTypeMiddle];
}

@end
