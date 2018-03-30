//
//  aaaaaModels.h
//  JsonModel
//
//  Created by Juvid on 18/3/16.
//  Copyright (c) 2016年 Juvid's. All rights reserved.
//

#import "JuBasicModels.h"
#import "aaaaaPagedataModels.h"
#import "aaaaaDataModels.h"

@interface aaaaaModels : JuBasicModels

@property (nonatomic,strong) NSString *sh_status;
@property (nonatomic,strong) aaaaaPagedataModels *sh_pageData;
@property (nonatomic,strong) NSArray *sh_data;
@property (nonatomic,strong) NSString *sh_msg;

@end
