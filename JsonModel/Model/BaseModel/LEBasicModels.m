//
//  BaseModel.m
//  JsonModel
//
//  Created by Juvid on 14-6-30.
//  Copyright (c) 2015年 Juvid's. All rights reserved.
//

#import "LEBasicModels.h"

@implementation LEBasicModels
+(id)initModel{
    id  baseModel = [[[self class] alloc]init] ;
    return baseModel;
}
//获取所以属性
+(NSArray *) getModelAllProperty{
    NSMutableArray *arrProperty=[NSMutableArray array];
    id  baseModel = [[[self class] alloc]init] ;
    unsigned int outCount, i;
    objc_property_t *properties =class_copyPropertyList([baseModel class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        [arrProperty addObject:propertyName];
    }
    free(properties);
    return arrProperty;
}
//字典转换成对象
+(id) setDictionaryForModel :(NSDictionary *) dic {
    if (![dic isKindOfClass:[NSDictionary class]]) return nil;
    id baseModel = [[[self class] alloc]init] ;
    Class class = [baseModel class];
    while (class!=[LEBasicModels class]) {
        unsigned int outCount, i;
        objc_property_t *properties =class_copyPropertyList([class class], &outCount);
        for (i = 0; i<outCount; i++)
        {
            objc_property_t property = properties[i];
            const char* char_f =property_getName(property);
            NSString *propertyName = [NSString stringWithUTF8String:char_f];
            NSString *dicKey=[propertyName substringFromIndex:Pro_Prefix.length];
            if (!baseModel)break;
            if ([[dic allKeys]containsObject:dicKey]) {
                [baseModel setValue:[[dic objectForKey:dicKey] isEqual:[NSNull null]]?@"":[dic objectForKey:dicKey] forKey:propertyName];
            }
            else{
                [baseModel setValue:@"" forKey:propertyName];
            }
        }
        free(properties);
        class = [class superclass];
    }

    return baseModel ;
}
//数组转换成数组对象
+(NSArray *) setArrayForModel :(NSArray *) arr {
    
    NSMutableArray *backArr = [[NSMutableArray alloc ]init];
    for (NSDictionary *dic in arr)
    {
        NSObject * baseModel = [self setDictionaryForModel:dic];
        [backArr addObject:baseModel];
        
    }
    return backArr ;
}



//对象转换成字典
+(NSMutableDictionary *) setModelForDictionary :(id) baseModel {
    NSMutableDictionary *dicModel = [NSMutableDictionary dictionary];
    Class class = [baseModel class];
    while (class!=[LEBasicModels class]) {
        unsigned int outCount, i;
        objc_property_t *properties =class_copyPropertyList(class, &outCount);
        for (i = 0; i<outCount; i++)
        {
            objc_property_t property = properties[i];
            const char* char_f =property_getName(property);
            NSString *propertyName = [NSString stringWithUTF8String:char_f];
            NSString *dicKey=[propertyName substringFromIndex:Pro_Prefix.length];
            if ([baseModel valueForKeyPath:propertyName]!=nil) {
                [dicModel setObject:[baseModel valueForKeyPath:propertyName] forKey:dicKey];
            }
            else {
                [dicModel setValue:@"" forKey:propertyName];
            }
            
        }
         free(properties);
        class = [class superclass];
    }
    
    return dicModel;
    
}

//对象转化成字符串
+(NSString *) setModelForString :(id ) baseModel{
    NSMutableString *strModel = [NSMutableString string];
    Class class = [baseModel class];
    while (class!=[LEBasicModels class]) {
        unsigned int outCount, i;
        objc_property_t *properties =class_copyPropertyList([class class], &outCount);
        for (i = 0; i<outCount; i++)
        {
            objc_property_t property = properties[i];
            const char* char_f =property_getName(property);
            NSString *propertyName = [NSString stringWithUTF8String:char_f];
              NSString *dicKey=[propertyName substringFromIndex:Pro_Prefix.length];
            id value=[baseModel valueForKeyPath:propertyName];
            if(!value) value=@"";
            if (i!=0) {
                [strModel appendFormat:@","];
            }
            [strModel appendFormat:@"%@=%@",dicKey,value];
        }
        free(properties);
        class = [class superclass];
    }
    return strModel;
    
}

-(void)setModelProValue:(NSString *)key value:(NSString *)value{
   [self setValue:value forKey:key];
}



@end
