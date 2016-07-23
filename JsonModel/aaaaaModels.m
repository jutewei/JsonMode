//
//  aaaaaModels.m
//  JsonModel
//
//  Created by Juvid on 18/3/16.
//  Copyright (c) 2016年 Juvid's. All rights reserved.
//

#import "aaaaaModels.h"

@implementation aaaaaModels

-(void)setSh_pageData:(NSDictionary *)sh_pageData{
   if ([sh_pageData isKindOfClass:[NSDictionary class]]) {
     _sh_pageData=[aaaaaPagedataModels setDictionaryForModel:sh_pageData];  
   }
}

-(void)setSh_data:(NSArray *)sh_data{
  if ([sh_data isKindOfClass:[NSArray class]]) {
      _sh_data=[aaaaaDataModels setArrayForModel:sh_data];
  }else{
      _sh_data=[NSArray new]; 
   }
}

@end