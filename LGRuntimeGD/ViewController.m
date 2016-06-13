//
//  ViewController.m
//  LGRuntimeGD
//
//  Created by mac on 16/6/12.
//  Copyright © 2016年 ZLG. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@property (nonatomic,strong)Person *person;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *ageText;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    Person *person = [[Person alloc] init];
    self.person = person;

}


- (IBAction)guiDangAction:(id)sender {
    
    NSString *filePath = [self getFilePath];
    self.person.name = self.nameText.text;
    self.person.age = [self.ageText.text intValue];
    [NSKeyedArchiver archiveRootObject:self.person toFile:filePath];
    
}

- (NSString *)getFilePath{
    
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"LGRiven.plist"];
    NSLog(@"%@",filePath);
    return filePath;
}

- (IBAction)decodeAction:(id)sender {
    
    self.person = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getFilePath] ];
    self.nameLabel.text = self.person.name;
    self.ageLabel.text = [NSString stringWithFormat:@"%d",self.person.age ];
    
}


@end
