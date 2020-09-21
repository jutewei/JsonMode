//
//  JuModel.m
//  JsonModel
//
//  Created by Juvid on 21/9/20.
//  Copyright (c) 2020年 Juvid's. All rights reserved.
//

#import "JuModel.h"

@implementation JuModel

-(void)setJu_result:(NSDictionary *)ju_result{
    _ju_result=[JuResultModel juSetDictionaryForModel:ju_result]; 
}

-(void)setJu_sys:(NSDictionary *)ju_sys{
    _ju_sys=[JuSysModel juSetDictionaryForModel:ju_sys]; 
}

@end