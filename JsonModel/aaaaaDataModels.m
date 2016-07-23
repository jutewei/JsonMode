//
//  aaaaaDataModels.m
//  JsonModel
//
//  Created by Juvid on 18/3/16.
//  Copyright (c) 2016年 Juvid's. All rights reserved.
//

#import "aaaaaDataModels.h"

@implementation aaaaaDataModels

-(void)setSh_skilled:(NSArray *)sh_skilled{
  if ([sh_skilled isKindOfClass:[NSArray class]]) {
      _sh_skilled=sh_skilled;
}else{
      _sh_skilled=[NSArray new]; 
   }
}

@end