//
//  LEBasicEncode.m
//  JsonModel
//
//  Created by Juvid on 15/6/12.
//  Copyright (c) 2015年 Juvid's. All rights reserved.
//

#import "LEBasicEncode.h"
#import "LEBasicModels.h"
@implementation LEBasicEncode
-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[[[self class] alloc]init];
    if (self) {
        Class class = [self class];
        while (class!=[LEBasicModels class]) {
            unsigned int outCount, i;
            objc_property_t *properties =class_copyPropertyList([class class], &outCount);
            for (i = 0; i<outCount; i++)
            {
                objc_property_t property = properties[i];
                const char* char_f =property_getName(property);
                NSString *propertyName = [NSString stringWithUTF8String:char_f];
                [self setValue:[aDecoder decodeObjectForKey:propertyName] forKey:propertyName] ;
            }
            free(properties);
            class = [class superclass];
        }
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    Class class = [self class];
    while (class!=[LEBasicModels class]) {
        unsigned int outCount, i;
        objc_property_t *properties =class_copyPropertyList([class class], &outCount);
        for (i = 0; i<outCount; i++)
        {
            objc_property_t property = properties[i];
            const char* char_f =property_getName(property);
            NSString *propertyName = [NSString stringWithUTF8String:char_f];
            [aCoder encodeObject:[self valueForKey:propertyName] forKey:propertyName];
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
        while (class!=[LEBasicModels class]) {
            unsigned int outCount, i;
            objc_property_t *properties =class_copyPropertyList([class class], &outCount);
            for (i = 0; i<outCount; i++)
            {
                objc_property_t property = properties[i];
                const char* char_f =property_getName(property);
                NSString *propertyName = [NSString stringWithUTF8String:char_f];
                [copy setValue:[[self valueForKey:propertyName] copyWithZone:zone] forKey:propertyName];
            }
            free(properties);
            class = [class superclass];
        }
    }
    return copy;
}

@end
