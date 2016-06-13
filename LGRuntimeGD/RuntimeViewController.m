//
//  RuntimeViewController.m
//  LGRuntimeGD
//
//  Created by mac on 16/6/12.
//  Copyright © 2016年 ZLG. All rights reserved.
//

#import "RuntimeViewController.h"
#import "Animal.h"
#import <objc/runtime.h>

@interface RuntimeViewController ()
@property (nonatomic,strong) Animal *animal;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextView *textTwoView;
@end

@implementation RuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"RunTime";
    Animal *animal = [[Animal alloc] init];
    self.animal = animal;
}

- (NSString *)getFilePath{
    
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"LGRiven.plist"];
    NSLog(@"%@",filePath);
    return filePath;
}

//解档
- (IBAction)clickAction:(id)sender {
    
    self.textTwoView.text = @"";
    
    id className = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getFilePath]];

    NSLog(@"className = %@",className);
    
    unsigned int count = 0;
    
    Ivar *ivars = class_copyIvarList([className class], &count);
    
    NSLog(@"%d",count);
    
    //遍历属性值
    for (int i=0; i<count; i++) {
        Ivar ivar = ivars[i];
        const char * nameS = ivar_getName(ivar);
        NSString *name = [NSString stringWithUTF8String:nameS];
        id object = [className valueForKey:name];
        
        NSLog(@"key = %@ ,value = %@",name ,object);
        
        self.textTwoView.text = [NSString stringWithFormat:@"%@\nkey = %@,value = %@",self.textTwoView.text,name ,object];
    }
    free(ivars);

}

//归档
- (IBAction)guiDangAction:(id)sender {
    
    self.textView.text = @"";
    
    
    unsigned int count = 0;
    
    Ivar *ivars = class_copyIvarList([self.animal class], &count);
    
    NSLog(@"%d",count);
    
    //遍历属性
    for (int i=0; i<count; i++) {
        
        //取出对应的成员变量
        Ivar ivar = ivars[i];
        
        //拿到变量名称
        const char * nameS = ivar_getName(ivar);
        
        //转OC字符串
        NSString *name = [NSString stringWithUTF8String:nameS];
        
        [self.animal setValue:[self getArcString] forKey:name];
        
        //字符串转OC对象
        id object = [self.animal valueForKey:name];
        
        NSLog(@"key = %@ ,value = %@",name ,object);
        
        //显示
        self.textView.text = [NSString stringWithFormat:@"%@\nkey = %@,value = %@",self.textView.text,name ,object];
    }
    free(ivars);
    
    [NSKeyedArchiver archiveRootObject:self.animal toFile:[self getFilePath]];
}


//随机获取随机字母或数字
- (NSString *)getArcString{
    
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < 3; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    return string;
}

@end
