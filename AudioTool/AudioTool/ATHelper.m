//
//  ATHelper.m
//  XVoice
//
//  Created by 佳佑 on 13-8-26.
//  Copyright (c) 2013年 shawnt22@gmail.com. All rights reserved.
//

#import "ATHelper.h"

@implementation ATHelper

+ (BOOL)isEmptyString:(NSString *)string
{
    return string && [string respondsToSelector:@selector(length)] && [string length] > 0 ? NO : YES;
}
+ (BOOL)createDirectoryIfNecessaryAtPath:(NSString *)path
{
	BOOL succeeded = YES;
	if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
		NSError *err = nil;
		succeeded = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&err];
		if (!succeeded) {
            NSLog(@"Create Path Error : %@", err);
		}
	}
	return succeeded;
}

+ (NSString *)rootPath
{
    NSString *path = nil;
    NSSearchPathDirectory searchPathDirectory = NSDocumentDirectory;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(searchPathDirectory,  NSUserDomainMask, YES);
	if ([paths count] > 0) {
		path = [[paths objectAtIndex:0] stringByAppendingPathComponent:[@"audio" lastPathComponent]];
	}
	return path;
}
+ (NSString *)tmpRecordFilePath:(NSString *)fileName
{
    return [NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
}

+ (NSError *)moveFileFromPath:(NSString *)fromPath ToPath:(NSString *)toPath
{
    NSError *err = nil;
    if ([ATHelper isEmptyString:fromPath]) {
        err = [ATErrorManager errorWithCode:ATErrorPramsWronge];
    } else {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:toPath]) {
            err = [ATErrorManager errorWithCode:ATErrorSaveFileExisted];
        } else {
            [fileManager moveItemAtPath:fromPath toPath:toPath error:&err];
        }
    }
    return err;
}
+ (NSError *)removeFileAtPath:(NSString *)filePath
{
    NSError *err = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:filePath error:&err];
    return err;
}

@end


@implementation ATErrorManager

+ (NSError *)errorWithCode:(ATErrorCode)code
{
    NSError *error = [NSError errorWithDomain:AT_ERROR_DOMAIN code:code userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[ATErrorManager descriptionWithCode:code], NSLocalizedDescriptionKey, nil]];
    return error;
}
+ (NSString *)descriptionWithCode:(ATErrorCode)code
{
    NSString *description = nil;
    switch (code) {
        case ATErrorPramsWronge:
            description = @"参数错误";
            break;
        case ATErrorSaveFileExisted:
            description = @"文件已存在";
            break;
        case ATErrorRecordFail:
            description = @"录制失败";
            break;
        default:
            description = @"未知错误";
            break;
    }
    return description;
}

@end


@implementation ATAsynCaller

+ (NSOperationQueue *)operationQueue
{
    return [NSOperationQueue currentQueue];
}
+ (void)asynCallBlock:(void (^)(void))block Completion:(void (^)(void))completion
{
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:block];
    operation.completionBlock = completion;
    [[ATAsynCaller operationQueue] addOperation:operation];
}

@end