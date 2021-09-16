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


@protocol juTest <NSObject>

@property (nonatomic,strong) NSString *ju_test1;
@property (nonatomic,strong) NSString *ju_test2;

@end

@interface JuModel : NSObject<juTest>

@property (nonatomic,strong) JuResultModel *ju_result;
@property (nonatomic,strong) JuSysModel *ju_sys;

@end
