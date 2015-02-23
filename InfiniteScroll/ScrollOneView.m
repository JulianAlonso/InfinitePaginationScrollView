//
//  ScrollOneView.m
//  InfiniteScroll
//
//  Created by Julian Alonso on 23/2/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import "ScrollOneView.h"

@implementation ScrollOneView

- (instancetype)initWithFrame:(CGRect)frame andBGColor:(UIColor *)color
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = color;
    }
    
    return self;
}

@end
