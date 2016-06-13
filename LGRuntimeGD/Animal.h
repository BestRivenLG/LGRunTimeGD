//
//  Animal.h
//  LGRuntimeGD
//
//  Created by mac on 16/6/12.
//  Copyright © 2016年 ZLG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGCoding.h"

@interface Animal : LGCoding

@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *name1;
@property (nonatomic,copy)NSString *name2;
@property (nonatomic,copy)NSString *name3;
@property (nonatomic,assign)int age;
@property (nonatomic,assign)int age1;
@property (nonatomic,assign)int age2;
@property (nonatomic,assign)int age3;

@end
