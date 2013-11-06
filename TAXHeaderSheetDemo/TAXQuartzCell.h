//
//  TAxSimpleCell.h
//  InfusionTable
//
//  Created by 金井 慎一 on 2013/10/11.
//  Copyright (c) 2013年 Twelve Axis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TAXCellContentView;
@class TAXContent;

@interface TAXQuartzCell : UICollectionViewCell
@property (nonatomic, strong) TAXCellContentView *cellContentView;
@property (nonatomic, strong) TAXContent *content;
@end
