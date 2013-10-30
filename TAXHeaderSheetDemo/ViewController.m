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
@end

@implementation ViewController

static NSString * const CellIdentifier = @"Cell";
//static NSString * const SeparatorTopIdentifier = @"TopSeparator";
static NSString * const SeparatorIdentifier = @"Separator";

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    // Set spreadsheet metrics.
    _headerSheet.numberOfRowsOfBody = 30;
    _headerSheet.numberOfColumnsOfBody = 20;

    _headerSheet.numberOfRowsOfHeader = 1;
    _headerSheet.numberOfRowsOfFooter = 2;
    _headerSheet.numberOfColumnsOfHeader = 1;
    _headerSheet.numberOfColumnsOfFooter = 1;

    // Set size of cell in each section
    _headerSheet.sizeForCell = CGSizeMake(50.0, 20.0);
    _headerSheet.widthOfHeaderCell = 50.0;
    _headerSheet.widthOfFooterCell = 50.0;
    _headerSheet.heightOfHeaderCell = 20.0;
    _headerSheet.heightOfFooterCell = 20.0;
    
    _headerSheet.heightOfHeader = _headerSheet.heightOfHeaderCell * _headerSheet.numberOfRowsOfHeader;
    _headerSheet.heightOfFooter = _headerSheet.heightOfFooterCell * _headerSheet.numberOfRowsOfFooter;
    _headerSheet.widthOfHeader = _headerSheet.widthOfHeaderCell * _headerSheet.numberOfColumnsOfHeader;
    _headerSheet.widthOfFooter = _headerSheet.widthOfFooterCell * _headerSheet.numberOfColumnsOfFooter;
    
    // Set size of separator
    _headerSheet.heightOfSeparatorTop = 2;
    _headerSheet.heightOfSeparatorBottom = 2;
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
            case TAXHeaderSheetSectionTypeBody:{
                UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCell:)];
                cell.gestureRecognizers = @[tapRecognizer];
            }
            case TAXHeaderSheetSectionTypeMiddleRight:
            case TAXHeaderSheetSectionTypeBottomMiddle:
            case TAXHeaderSheetSectionTypeBottomRight:{
                cell.textLabel.text = [NSString stringWithFormat:@"%d-%d", row, column];
                cell.backgroundColor = [UIColor whiteColor];
                break;
            }
            case TAXHeaderSheetSectionTypeTopMiddle:
            case TAXHeaderSheetSectionTypeTopRight:{
                UILongPressGestureRecognizer *pressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pressedCell:)];
                pressRecognizer.minimumPressDuration = 2.0;
                cell.gestureRecognizers = @[pressRecognizer];
                
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

#pragma mark - HeaderSheet Delegate

- (CGFloat)headerSheet:(TAXHeaderSheet *)headerSheet bottomSpacingBelowRow:(NSUInteger)row inSectionType:(TAXHeaderSheetSectionType)sectionType
{
    return 1.0;
}
 
- (CGFloat)headerSheet:(TAXHeaderSheet *)headerSheet trailingSpacingAfterColumn:(NSUInteger)column inSectionType:(TAXHeaderSheetSectionType)sectionType
{
    return 1.0;
}

# pragma mark - Tap Handler

- (void)tappedCell:(id)sender
{
    UIGestureRecognizer *gestureRecognizer = (UIGestureRecognizer *)sender;
    UICollectionViewCell *cell =  (UICollectionViewCell *)gestureRecognizer.view;
    NSIndexPath *indexPath = [_headerSheet indexPathForCell:cell inSectionType:TAXHeaderSheetSectionTypeBody];
    NSLog(@"Tapped row:%d column:%d", indexPath.section, indexPath.item);
}

- (void)pressedCell:(id)sender
{
    UIGestureRecognizer *gestureRecognizer = (UIGestureRecognizer *)sender;
    UICollectionViewCell *cell =  (UICollectionViewCell *)gestureRecognizer.view;
    NSIndexPath *indexPath = [_headerSheet indexPathForCell:cell inSectionType:TAXHeaderSheetSectionTypeTopMiddle];
    NSLog(@"Long pressed column:%d", indexPath.item);
}

@end
