TAXHeaderSheet
============
A spreadsheet view that have header/footer

<img src="https://farm8.staticflickr.com/7360/10574026144_661661a99f.jpg" width="320" height="480" alt="TAXHeaderSheet_SC_1">

##Requirements

iOS 6.0 or later

##Dependency

TAXSpreadSheet 0.1.1 or later

##Installation
via CocoaPods

```Podfile
pod 'TAXHeaderSheet', :git => 'https://github.com/kanaishinichi/TAXHeaderSheet.git'
```

##Usage

Import header

```objectivec
#import "TAXHeaderSheet.h"
```

Instantiate TAXHeaderSheet and register UICollectionViewCell or subclass for cells the same as UICollectionView.

```objectivec
TAXHeaderSheet *headerSheet = [[TAXHeaderSheet alloc] initWithFrame:CGRectMake(0.0. 0.0. 100.0, 100.0)];
[headerSheet registerClass:[UICollectionViewCell class] forCellInAllSectionWithReuseIdentifier:@"Cell"];
```
Set metrics of the sheet via properties.

```objectivec
headerSheet.numberOfRowsOfBody = 30;
headerSheet.numberOfColumnsOfBody = 20;

headerSheet.numberOfRowsOfHeader = 1;
headerSheet.numberOfRowsOfFooter = 2;
headerSheet.numberOfColumnsOfHeader = 1;
headerSheet.numberOfColumnsOfFooter = 1;

headerSheet.sizeForCell = CGSizeMake(50.0, 20.0);
headerSheet.widthOfHeaderCell = 50.0;
headerSheet.widthOfFooterCell = 50.0;
headerSheet.heightOfHeaderCell = 20.0;
headerSheet.heightOfFooterCell = 20.0;
    
headerSheet.heightOfHeader = headerSheet.heightOfHeaderCell * 
headerSheet.numberOfRowsOfHeader;
headerSheet.heightOfFooter = headerSheet.heightOfFooterCell * headerSheet.numberOfRowsOfFooter;
headerSheet.widthOfHeader = headerSheet.widthOfHeaderCell * headerSheet.numberOfColumnsOfHeader;
headerSheet.widthOfFooter = headerSheet.widthOfFooterCell * headerSheet.numberOfColumnsOfFooter;
```

 or by implementing delegate methods eg. ```headerSheet:heightAtRow:ofSectionType:```
There is priority for cell height/width:
Header > Footer > Body > Property.

Set DataSource and Delegate objects and implement those methods.

```
- (UICollectionViewCell*)headerSheet:(TAXHeaderSheet *)headerSheet cellAtRow:(NSUInteger)row column:(NSUInteger)column inSectionType:(TAXHeaderSheetSectionType)sectionType
{
    TAXLabelCell *cell = [headerSheet dequeueReusableCellInSectionType:sectionType withReuseIdentifier:CellIdentifier forRow:row column:column];
    // Customize cell.
    return cell;
}
```
You should return dequeued UICollectionViewCell subclass in ```headerSheet:cellAtRow:column:inSectionType```

##Customize

###Use custom views for separators.

You can use custom UICollectionReusableView subclass for separators.
You should register class and dequeue view from HeaderSheet.
In case of not using view, return nil.

```objectivec
- (UICollectionReusableView *)headerSheet:(TAXHeaderSheet *)headerSheet separatorViewOfSeparatorType:(TAXHeaderSheetSeparatorType)separatorType
{
    UICollectionReusableView *view = [headerSheet dequeueReusableSeparatorViewOfSeparatorType:separatorType withReuseIdentifier:@"Separator"];
    view.backgroundColor = [UIColor blueColor];
    return view;
}
```

###Use custom views for inter-row/column of each section.

You can use custom UICollectionReusableView subclass for inter-row/column by implementing delegate methods.
You should register class and dequeue view from SpreadSheet.
In case of not using view, return nil.

```objectivec
- (UICollectionReusableView *)headerSheet:(TAXHeaderSheet *)headerSheet interRowViewInSectionType:(TAXHeaderSheetSectionType)sectionType belowRow:(NSUInteger)row;
{
	if (row == 0) {
		UICollectionReusableView *view = [spreadSheet dequeueReusableInterRowViewWithIdentifier:@"View" belowRow:row];
		return view;
	} else {
		return nil;
	}
}
```

##License

MIT License