//
//  Person.m
//  LGRuntimeGD
//
//  Created by mac on 16/6/12.
//  Copyright © 2016年 ZLG. All rights reserved.
//

#import "Person.h"

@implementation Person




//归档
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInt: self.age forKey:@"age"];
    
}

//解压
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        
        _name = [aDecoder decodeObjectForKey:@"name"];
        _age= [aDecoder decodeIntForKey:@"age"] ;
        
    }
    
    return self;
}

@end
