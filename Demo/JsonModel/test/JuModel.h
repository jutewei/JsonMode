//
//  JuModel.h
//  JsonModel
//
//  Created by Juvid on 21/9/20.
//  Copyright (c) 2020年 Juvid's. All rights reserved.
//

#import "NSObject+JsonModel.h"
#import "JuResultModel.h"
#import "JuSysModel.h"

@interface JuModel : NSObject

@property (nonatomic,strong) JuResultModel *ju_result;
@property (nonatomic,strong) JuSysModel *ju_sys;

@end