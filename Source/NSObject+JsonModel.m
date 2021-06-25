//
//  NSObject+JsonModel.m
//  PABase
//
//  Created by Juvid on 2018/11/28.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "NSObject+JsonModel.h"
#import <objc/runtime.h>
#import "NSObject+CopyModel.h"
@implementation NSObject (JsonModel)
//-(NSArray *)juIgnorekeys{
//    return nil;
//}
+(id)juInitM{
    id  baseModel = [[[self class] alloc]init] ;
    return baseModel;
}

//字典转换成对象
+(id)juToModel:(NSDictionary *)dic {
    return [self juToModel:dic withModel:nil];
}
-(id)juToModel:(NSDictionary *)dic{
    return [NSObject juToModel:dic withModel:self];
}
//字典转换成对象
+(id)juToModel:(NSDictionary *)obj withModel:(NSObject *)model{
    BOOL isNewObject = false;
    if (!model) {
        isNewObject=YES;
        model = [[[self class] alloc]init] ;
    }
    if (obj==nil) {
        obj=@{};
    }else if (![obj isKindOfClass:[NSDictionary class]]) {
        return obj;
    }

//    NSArray *juIgnorekeys=[model juIgnorekeys];
    Class class = [model class];
    while (class!=[self juBaseClass]) {
        unsigned int outCount, i;
        objc_property_t *properties =class_copyPropertyList([class class], &outCount);
        for (i = 0; i<outCount; i++)
        {
            objc_property_t property = properties[i];
            const char *propert_f=property_getAttributes(property);//获取属性类型;
            NSString *propertType=[NSString stringWithUTF8String:propert_f];
            const char* char_f =property_getName(property);
            NSString *propertyName = [NSString stringWithUTF8String:char_f];
            NSString *dicKey=[self getDicKey:propertyName];

            id value=obj[dicKey];

//            if (juIgnorekeys&&[juIgnorekeys containsObject:dicKey]) {
//                continue;
//            }
            if ([propertType containsString:@"<JuIgnore>"]) {
                continue;
            }

            if (value) {
                value=[value isEqual:[NSNull null]]?@"":value;
                if ([propertType hasPrefix:@"TQ,N,V"]) {///< 无符号整数
                    [model setValue:@([value integerValue]) forKey:propertyName];
                }
                else{
                    if ([propertType hasPrefix:@"T@\"NSArray"]&&![value isKindOfClass:[NSArray class]]){
                        value=[NSMutableArray array];
                    }else if ([propertType hasPrefix:@"T@\"NSString"]) {///< 转str
                        value=[NSString stringWithFormat:@"%@",value];
                    }
                    [model setValue:value forKey:propertyName];
                }
            }
            else{//当前属性没有返回值
//                if ([propertType containsString:@",R,"]) continue;

                if (isNewObject&&[propertType hasPrefix:@"T@\"NSString"]) {
                    [model setValue:@"" forKey:propertyName];
                }
            }
        }
        free(properties);
        class = [class superclass];
    }
    return model ;
}

//数组转换成数组对象
+(NSArray *)juToModelArr:(NSArray *)arr {
    NSMutableArray *backArr = [[NSMutableArray alloc ]init];
    if(![arr isKindOfClass:[NSArray class]])return backArr;
    for (NSDictionary *dic in arr)
    {
        if ([dic isKindOfClass:[NSDictionary class]]) {
            NSObject * model = [self juToModel:dic];
            [backArr addObject:model];
        }
//        修复
        else if(dic){
            [backArr addObject:dic];
        }
    }
    return backArr ;
}

-(NSMutableDictionary *)juToDictionary{
    return [[self class] juToDictionary:self];
}

//对象转换成字典
+(NSMutableDictionary *)juToDictionary:(NSObject *)model {
    if (!model) {
        return [NSMutableDictionary dictionary];
    }
    else if ([model isKindOfClass:[NSDictionary class]]) {
        return [model mutableCopy];//防止死循环
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    NSArray *juIgnorekeys=[model juIgnorekeys];
    Class class = [self class];
    while (class!=[self juBaseClass]) {
        unsigned int outCount, i;
        objc_property_t *properties =class_copyPropertyList(class, &outCount);
        for (i = 0; i<outCount; i++)
        {
            objc_property_t property = properties[i];
            const char* char_f =property_getName(property);
            NSString *propertyName = [NSString stringWithUTF8String:char_f];
            NSString *dicKey=[self getDicKey:propertyName];
            const char *propert_f=property_getAttributes(property);//获取属性类型;
            NSString *propertType=[NSString stringWithUTF8String:propert_f];

//            if (juIgnorekeys&&[juIgnorekeys containsObject:dicKey]) {
//                continue;
//            }
            if ([propertType containsString:@"<JuIgnore>"]) {
                continue;
            }

            if ([model valueForKeyPath:propertyName]!=nil) {
                [dic setObject:[model valueForKeyPath:propertyName] forKey:dicKey];
            }else if ([propertType hasPrefix:@"T@\"NSArray"]){
                [dic setValue:@[] forKey:dicKey];
            }else if([propertType hasPrefix:@"T@\"NSDictionary"]){
                [dic setValue:@{} forKey:dicKey];
            }else {
                [dic setValue:@"" forKey:dicKey];
            }

        }
         free(properties);
        class = [class superclass];
    }
    return dic;
}

//把模型转换回数组
+(NSArray *)juToDicArray:(NSArray *) arr{
    if(![arr isKindOfClass:[NSArray class]])return @[];
    NSMutableArray *backArr = [[NSMutableArray alloc ]init];
    for (id model in arr)
    {
        NSDictionary * dic = [self juToDictionary:model];
        [backArr addObject:dic];
    }
    return backArr;
}

-(NSString *)juToString{
    return [NSObject juToString:self];
}

//对象转化成字符串
+(NSString *)juToString:(id )model{
    NSMutableString *strModel = [NSMutableString string];
    Class class = [model class];
    while (class!=[self juBaseClass]) {
        unsigned int outCount, i;
        objc_property_t *properties =class_copyPropertyList([class class], &outCount);
        for (i = 0; i<outCount; i++)
        {
            objc_property_t property = properties[i];
            const char* char_f =property_getName(property);
            NSString *propertyName = [NSString stringWithUTF8String:char_f];
            NSString *dicKey=[self getDicKey:propertyName];
            id value=[model valueForKeyPath:propertyName];
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
+(NSString *)getDicKey:(NSString *)propertyName{
    for (NSString *prefix in JU_ProPrefixs) {
        if ([propertyName hasPrefix:prefix]) {
            return  [propertyName substringFromIndex:prefix.length];
        }
    }
    return propertyName;
}

-(void)juModelKey:(NSString *)key value:(NSString *)value{
   [self setValue:value forKey:key];
}
//获取所以属性
+(NSArray *)juAllProperty{
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

//-(NSString *)juVauleForkey:(NSString *)key{
//    NSArray *sh_ArrProperty=[[self class] juAllProperty];
//    NSString *Property=[NSString stringWithFormat:@"%@%@",JU_Model_Prefix,key];
//    if ([sh_ArrProperty containsObject:Property]) {
//        return  [self valueForKey:Property];
//    }
//    return @"";
//}
@end
