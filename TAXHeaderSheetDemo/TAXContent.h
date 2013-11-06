//
//  TAxContent.h
//  InfusionTable
//
//  Created by 金井 慎一 on 2013/10/11.
//  Copyright (c) 2013年 Twelve Axis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TAXContent : NSObject
@property (nonatomic, readonly) NSString *text;

// Designated initializer
- (instancetype)initWithText:(NSString *)text;
@end
