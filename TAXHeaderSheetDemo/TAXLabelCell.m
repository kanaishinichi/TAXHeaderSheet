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

@end
