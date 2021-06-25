//
//  NSObject+encode.h
//  JsonModel
//
//  Created by Juvid on 2019/12/13.
//  Copyright © 2019 Juvid. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (CopyModel)

-(void)mtDestroyDealloc;//重置单例

-(void)mtMutableCopy:(id)baseClass;

+(Class)juBaseClass;
-(Class)juBaseClass;
@end

NS_ASSUME_NONNULL_END
