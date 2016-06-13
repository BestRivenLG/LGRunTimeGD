//
//  Person.h
//  LGRuntimeGD
//
//  Created by mac on 16/6/12.
//  Copyright © 2016年 ZLG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCoding>
@property (nonatomic,copy)NSString *name;
@property (nonatomic,assign)int age;
@end
