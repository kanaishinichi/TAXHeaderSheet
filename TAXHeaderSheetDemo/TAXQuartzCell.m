//
//  TAxSimpleCell.m
//  InfusionTable
//
//  Created by 金井 慎一 on 2013/10/11.
//  Copyright (c) 2013年 Twelve Axis. All rights reserved.
//

#import "TAXQuartzCell.h"
#import "TAXCellContentView.h"
#import "TAXContent.h"

@implementation TAXQuartzCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _cellContentView = [[TAXCellContentView alloc] initWithFrame:self.contentView.frame withCell:self];
        _cellContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _cellContentView.contentMode = UIViewContentModeLeft;
        [self.contentView addSubview:_cellContentView];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    _cellContentView.highlighted = highlighted;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    _cellContentView.backgroundColor = backgroundColor;
}

@end
