//
//  NSObject+JsonModel.h
//  PABase
//
//  Created by Juvid on 2018/11/28.
//  Copyright © 2018年 Juvid. All rights reserved.
//
/**未使用**/
#import <Foundation/Foundation.h>
//#import "NSArray+Safe.h"
#define JU_ProPrefixs @[@"zl_",@"ju_"]
//NS_ASSUME_NONNULL_BEGIN

@protocol JuIgnore
@end

@interface NSObject (JsonModel)

//忽略的属性集合
//-(NSArray *)juIgnorekeys;

/**
 *  初始化model对象
 */
+(id)juInitM;

/**
 *  @author Juvid, 15-07-15 10:07:29
 *
 *  json数据转对象
 *
 *  @param dic 网络返回的字典
 *
 *  @return 返回转换好的对象
 */
-(id)juToModel:(NSDictionary *)dic;

+(id)juToModel:(NSDictionary *)dic;

/**
 *  @author Juvid, 15-07-15 10:07:34
 *
 *  json数据转对象数组
 *
 *  @param arr 网络返回的数组包含相同的字典
 *
 *  @return 返回转换好的数组，数组里为对象
 */
+(NSArray *)juToModelArr:(NSArray <NSDictionary *>*)arr;

/// 对象转化成字符串key=value中间逗号分隔形式
-(NSString *)juToString;
/**
 *  @author Juvid, 15-07-15 10:07:42
 *
 *  对象转化成字符串key=value中间逗号分隔形式
 *
 *  @param model 要转换的对象
 *
 *  @return 返回对象字符串
 */

+(NSString *)juToString:(NSObject *)model;

//对象转换成字典
-(NSMutableDictionary *)juToDictionary;
/**
 *  @author Juvid, 15-07-15 10:07:17
 *
 *   对象转换成字典
 *
 *  @param model 转换的对象
 *
 *  @return 返回字典
 */
+(NSMutableDictionary *)juToDictionary:(NSObject *)model;

//对象数组转换成数字
/**
 *  @author Juvid, 15-07-15 10:07:17
 *
 *   对象数组转换成字典数组
 *
 *  @param arr 转换的对象数组
 *
 *  @return 返回字典
 */
+(NSArray *)juToDicArray:(NSArray *)arr;
/**
 *  @author Juvid, 15-07-15 10:07:20
 *
 *  设置对象属性值
 *
 *  @param key   键
 *  @param value 值
 */
-(void)juModelKey:(NSString *)key value:(NSString *)value;
/**
 *  @author Juvid, 15-07-15 10:07:47
 *
 *  得到所有属性
 *
 *  @return 属性数组
 */
+(NSArray *)juAllProperty;
//-(NSString *)juVauleForkey:(NSString *)key;
@end

//NS_ASSUME_NONNULL_END
