//
//  JuvidModels.h
//  JsonModel
//
//  Created by Juvid on 13/9/15.
//  Copyright (c) 2015年 Juvid's. All rights reserved.
//

#import "LEBasicModels.h"
#import "JuvidResultModels.h"
#import "JuvidSysModels.h"

@interface JuvidModels : LEBasicModels

@property (nonatomic,strong) JuvidResultModels *m_result;
@property (nonatomic,strong) JuvidSysModels *m_sys;

@end