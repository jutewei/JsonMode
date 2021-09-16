#ifdef __OBJC__
#import <Cocoa/Cocoa.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "JuBaseEncode.h"
#import "NSArray+Safe.h"
#import "NSObject+CopyModel.h"
#import "NSObject+JsonModel.h"

FOUNDATION_EXPORT double JUJsonModelVersionNumber;
FOUNDATION_EXPORT const unsigned char JUJsonModelVersionString[];

