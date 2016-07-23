//
//  JuvidModels.m
//  JsonModel
//
//  Created by Juvid on 13/9/15.
//  Copyright (c) 2015年 Juvid's. All rights reserved.
//

#import "JuvidModels.h"

@implementation JuvidModels

-(void)setM_result:(NSDictionary *)m_result{
    _m_result=[JuvidResultModels setDictionaryForModel:m_result];
}

-(void)setM_sys:(NSDictionary *)m_sys{
    _m_sys=[JuvidSysModels setDictionaryForModel:m_sys];
}

@end