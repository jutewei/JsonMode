//
//  ViewController.h
//  JsonModel
//
//  Created by Juvid on 15/9/10.
//  Copyright (c) 2015年 Juvid's. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController{
    NSString *path_Desktop;
    id juvidM;
//    NSString *file_name;
}
@property (weak) IBOutlet NSButton *ju_Model;
@property (weak) IBOutlet NSTextField *ju_ClassName;
@property (weak) IBOutlet NSTextField *ju_Warm;

@property (unsafe_unretained) IBOutlet NSTextView *ju_textJson;
- (IBAction)ju_ProductionModel:(NSButton *)sender;

@end

