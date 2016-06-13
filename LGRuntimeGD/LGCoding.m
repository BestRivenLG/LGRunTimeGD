//
//  LGCoding.m
//  LGRuntimeGD
//
//  Created by mac on 16/6/13.
//  Copyright © 2016年 ZLG. All rights reserved.
//

#import "LGCoding.h"

#import <objc/runtime.h>

@interface LGCoding ()<NSCoding>

@end


@implementation LGCoding

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int count = 0;
    
    Ivar *ivars = class_copyIvarList([self class], &count);
    
    NSLog(@"%d",count);
    for (int i=0; i<count; i++) {
        
        //取出对应的成员变量
        Ivar ivar = ivars[i];
        //拿到变量名称
        const char * nameS = ivar_getName(ivar);
        //转OC字符串
        NSString *name = [NSString stringWithUTF8String:nameS];
        //字符串转OC对象
        id object = [self valueForKey:name];
        //归档
        [aCoder encodeObject:object forKey:name];
        
    }
    free(ivars);
    
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        //解档
        unsigned int count = 0;
        
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (int i=0; i<count; i++) {
            Ivar ivar = ivars[i];
            const char * nameS = ivar_getName(ivar);
            NSString *key = [NSString stringWithUTF8String:nameS];
            
            //解档
            id object = [aDecoder decodeObjectForKey:key];
            //设置到成员变量身上
            [self setValue:object forKey:key];
        }
        free(ivars);
    }
    return self;
}
@end
