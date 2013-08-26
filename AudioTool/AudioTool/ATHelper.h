//
//  ATHelper.h
//  XVoice
//
//  Created by 佳佑 on 13-8-26.
//  Copyright (c) 2013年 shawnt22@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATDefine.h"

@interface ATHelper : NSObject

+ (BOOL)isEmptyString:(NSString *)string;
+ (BOOL)createDirectoryIfNecessaryAtPath:(NSString *)path;

+ (NSString *)rootPath;
+ (NSString *)tmpRecordFilePath:(NSString *)fileName;

+ (NSError *)moveFileFromPath:(NSString *)fromPath ToPath:(NSString *)toPath;
+ (NSError *)removeFileAtPath:(NSString *)filePath;

@end


@interface ATErrorManager : NSObject

+ (NSError *)errorWithCode:(ATErrorCode)code;

@end


@interface ATAsynCaller : NSObject

+ (void)asynCallBlock:(void (^)(void))block Completion:(void (^)(void))completion;

@end