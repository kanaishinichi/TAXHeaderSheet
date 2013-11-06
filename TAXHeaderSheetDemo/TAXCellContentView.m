//
//  TAxCellContentView.m
//  InfusionTable
//
//  Created by 金井 慎一 on 2013/10/11.
//  Copyright (c) 2013年 Twelve Axis. All rights reserved.
//

#import "TAXCellContentView.h"
#import "TAXQuartzCell.h"
#import "TAXContent.h"

@interface TAXCellContentView ()
{
    BOOL _highlighted;
    TAXQuartzCell *_cell;
}
@end

@implementation TAXCellContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [self initWithFrame:frame withCell:nil];
    if (self) {
        // Initialization code
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame withCell:(TAXQuartzCell *)cell
{
    self = [super initWithFrame:frame];
    if (self) {
        _cell = cell;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    _highlighted = highlighted;
    [self setNeedsDisplay];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIColor *color;
    if (_highlighted) {
        [[UIColor whiteColor] setFill];
        color = [UIColor whiteColor];
    } else {
        [[UIColor blackColor] setFill];
        color = [UIColor blackColor];
    }
    
    // Paragraph
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentCenter;

    NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraph,
                                 NSFontAttributeName:[UIFont systemFontOfSize:16.0],
                                 NSForegroundColorAttributeName:color};
    CGSize textSize = [_cell.content.text sizeWithAttributes:attributes];

    // Set drawing rect
    CGRect textRect = CGRectInset(rect, 0.0, (rect.size.height - textSize.height)/2);

    // Frame for Debug
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor colorWithRed:1 green:0 blue:0 alpha:0.1] setFill];
    [[UIColor colorWithRed:1 green:0 blue:0 alpha:1] setStroke];
    CGContextSetLineWidth(context, 2);
    CGContextFillRect(context, textRect);
    CGContextStrokeRect(context, textRect);
    
    // Draw text
    [_cell.content.text drawInRect:textRect withAttributes:attributes];
}

@end
