//
//  TAxContent.m
//  InfusionTable
//
//  Created by 金井 慎一 on 2013/10/11.
//  Copyright (c) 2013年 Twelve Axis. All rights reserved.
//

#import "TAXContent.h"

@implementation TAXContent

- (instancetype)initWithText:(NSString *)text
{
    self = [super init];
    if (self != nil) {
        _text = [text copy];
    }
    return self;
}

@end
