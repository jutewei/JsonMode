//
//  NSObject+encode.m
//  JsonModel
//
//  Created by Juvid on 2019/12/13.
//  Copyright © 2019 Juvid. All rights reserved.
//

#import "NSObject+CopyModel.h"
#import <objc/runtime.h>
@implementation NSObject (CopyModel)
-(void)mtMutableCopy:(id)baseClass{
    if (baseClass) {
        Class class = [baseClass class];
        while (class!=[self juBaseClass]) {
            unsigned int outCount, i;
            objc_property_t *properties =class_copyPropertyList([class class], &outCount);
            for (i = 0; i<outCount; i++)
            {
                objc_property_t property = properties[i];
                const char* char_f =property_getName(property);
                NSString *propertyName = [NSString stringWithUTF8String:char_f];
                if([baseClass valueForKeyPath:propertyName]!=nil&&![[baseClass valueForKeyPath:propertyName]isEqual:@""]){
                    [self setValue:[baseClass valueForKey:propertyName]  forKey:propertyName];
                }
            }
            free(properties);
            class = [class superclass];
        }
    }

}
-(void)mtDestroyDealloc{
    Class class = [self class];
    while (class!=[self juBaseClass]) {
        unsigned int outCount, i;
        objc_property_t *properties =class_copyPropertyList([class class], &outCount);
        for (i = 0; i<outCount; i++)
        {
            objc_property_t property = properties[i];
            const char* char_f =property_getName(property);
            NSString *propertyName = [NSString stringWithUTF8String:char_f];
//             const char *propert_f=property_getAttributes(property);//获取属性类型;
//             NSString *propertType=[NSString stringWithUTF8String:propert_f];
            id value = [self valueForKey:propertyName];
            if (value&&![value isKindOfClass:[NSNumber class]]) {
                 [self setValue:nil forKey:propertyName];
            }else if ([value isKindOfClass:[NSNumber class]]){
                [self setValue:@(0) forKey:propertyName];
            }
            propertyName=nil;
        }
        class = [class superclass];
        free(properties);
    }
}
+(Class)juBaseClass{
    return [NSObject class];
}
-(Class)juBaseClass{
    return [NSObject class];
}
@end
