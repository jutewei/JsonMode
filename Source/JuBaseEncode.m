//
//  LEBasicEncode.m
//  JsonModel
//
//  Created by Juvid on 15/6/12.
//  Copyright (c) 2015年 Juvid(zhutianwei). All rights reserved.
//

#import "JuBaseEncode.h"
#import <objc/runtime.h>
@implementation JuBaseEncode
-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[[[self class] alloc]init];
    if (self) {
        Class class = [self class];
        while (class!=[self juBaseClass]) {
            unsigned int outCount, i;
            objc_property_t *properties =class_copyPropertyList([class class], &outCount);
            for (i = 0; i<outCount; i++)
            {
                objc_property_t property = properties[i];
                const char* char_f =property_getName(property);
                NSString *propertyName = [NSString stringWithUTF8String:char_f];
                id value = [aDecoder decodeObjectForKey: propertyName];
                if (value) {
                    [self setValue:value forKey:propertyName] ;
                }
                
            }
            free(properties);
            class = [class superclass];
        }
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    Class class = [self class];
    while (class!=[self juBaseClass]) {
        unsigned int outCount, i;
        objc_property_t *properties =class_copyPropertyList([class class], &outCount);
        for (i = 0; i<outCount; i++)
        {
            objc_property_t property = properties[i];
            const char* char_f =property_getName(property);
            NSString *propertyName = [NSString stringWithUTF8String:char_f];
             id value = [self valueForKey:propertyName];
            if (value) {
                [aCoder encodeObject:value forKey:propertyName];
            }
           
        }
        free(properties);
        class = [class superclass];
    }
    
}
//拷贝对象
- (id)copyWithZone:(NSZone *)zone
{
    NSObject *copy = [[[self class] alloc] init];
    if (copy) {
        Class class = [copy class];
        while (class!=[self juBaseClass]) {
            unsigned int outCount, i;
            objc_property_t *properties =class_copyPropertyList([class class], &outCount);
            for (i = 0; i<outCount; i++)
            {
                objc_property_t property = properties[i];
                const char* char_f =property_getName(property);
                NSString *propertyName = [NSString stringWithUTF8String:char_f];
                id value = [self valueForKey:propertyName];
                if (value) {
                    [copy setValue:[value copyWithZone:zone] forKey:propertyName];
                }
            }
            free(properties);
            class = [class superclass];
        }
    }
    return copy;
}

@end
