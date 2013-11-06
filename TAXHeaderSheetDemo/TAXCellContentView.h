//
//  TAxCellContentView.h
//  InfusionTable
//
//  Created by 金井 慎一 on 2013/10/11.
//  Copyright (c) 2013年 Twelve Axis. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TAXQuartzCell;

@interface TAXCellContentView : UIView
@property (nonatomic, assign) BOOL highlighted;
// Designated initializer
- (instancetype)initWithFrame:(CGRect)frame withCell:(TAXQuartzCell *)cell;
@end
