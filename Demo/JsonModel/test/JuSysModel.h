//
//  JuSysModel.h
//  JsonModel
//
//  Created by Juvid on 21/9/20.
//  Copyright (c) 2020年 Juvid's. All rights reserved.
//

#import "NSObject+JsonModel.h"

@interface JuSysModel : NSObject

@property (nonatomic,strong) NSString *ju_update_time;
@property (nonatomic,strong) NSString *ju_create_name;
@property (nonatomic,strong) NSString *ju_version_addr;
@property (nonatomic,strong) NSString *ju_update_name;
@property (nonatomic,strong) NSString *ju_app_type;
@property (nonatomic,strong) NSString *ju_pk_id;
@property (nonatomic,strong) NSString *ju_create_time;
@property (nonatomic,strong) NSString *ju_version_number;
@property (nonatomic,strong) NSString *ju_is_replace;

@end