//
//  IPModel.m
//  Xiuxiu
//
//  Created by Mac on 15/6/27.
//  Copyright (c) 2015年 yangdeger@gmail.com. All rights reserved.
//

#import "IPModel.h"

@implementation IPModel

-(NSUInteger)hash
{
    NSUInteger rtn = 0;
    rtn += [_ipOrDomain hash];
    rtn += _port;
    return rtn;
}

-(BOOL)isEqual:(id)object
{
    //judge by pointer
    if (object == self) {
        return YES;
    }
    
    //judge by class
    if (object == nil || ![object isMemberOfClass:[self class]]) {
        return NO;
    }
    
    //judge by value
    IPModel* o = (IPModel*)object;
    return [o.ipOrDomain isEqualToString:self.ipOrDomain]
    && o.port == self.port;
}

@end
