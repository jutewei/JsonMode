//
//  LEBasicEncode.h
//  JsonModel
//
//  Created by Juvid on 15/6/12.
//  Copyright (c) 2015年 Juvid(zhutianwei). All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+CopyModel.h"
@interface JuBaseEncode : NSObject<NSCopying,NSCoding>

@end

/**
 *  @property 各种类型
 *  Td,N,V_isdouble
 *  T@"NSDate",&,N,V_isNSDate
 *  T@"NSString",&,N,V_isNSString
 *  Tc,N,V_isNextPassedBOOL
 *  Tc,N,V_isPassedBOOL
 *  Tc,N,V_ischar
 *  Tf,N,V_isCGFloat
 *  Tf,N,V_isfloat
 *  TI,N,V_isNSUInteger
 *  Ti,N,V_isNSInteger
 *  Ti,N,V_isint
 */
