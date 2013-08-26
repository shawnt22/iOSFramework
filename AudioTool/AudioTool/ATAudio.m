//
//  ATAudio.m
//  XVoice
//
//  Created by 佳佑 on 13-8-26.
//  Copyright (c) 2013年 shawnt22@gmail.com. All rights reserved.
//

#import "ATAudio.h"
#import "ATHelper.h"

#pragma mark - ATAudio
static NSString *kATAudioTitle = @"ttl";
static NSString *kATAudioFileName = @"fname";

@interface ATAudio ()
@property (nonatomic, copy) NSString *fileName;
@end

@implementation ATAudio

#pragma mark init
- (id)init
{
    self = [super init];
    if (self) {
        self.title = nil;
        self.recordTime = self.saveTime = 0.0;
        self.fileName = nil;
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    if (![ATHelper isEmptyString:self.title]) [aCoder encodeObject:self.title forKey:kATAudioTitle];
    if (![ATHelper isEmptyString:self.fileName]) [aCoder encodeObject:self.fileName forKey:kATAudioFileName];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        id v = [aDecoder decodeObjectForKey:kATAudioTitle];
        self.title = v;
        v = [aDecoder decodeObjectForKey:kATAudioFileName];
        self.fileName = kATAudioFileName;
    }
    return self;
}
- (CFStringRef)cfFileName
{
    return (__bridge CFStringRef)(self.title);
}
- (CFStringRef)cfFilePath
{
    return (__bridge CFStringRef)(self.filePath);
}
- (NSString *)filePath
{
    return [[ATHelper rootPath] stringByAppendingPathComponent:self.title];
}

#pragma mark save & clear
- (BOOL)save:(BOOL)asynchronous
{
    BOOL result = YES;
    
    [ATHelper createDirectoryIfNecessaryAtPath:[ATHelper rootPath]];
    
    NSString *tmpRecordFilePath = [ATHelper tmpRecordFilePath:self.fileName];
    NSString *targetFilePath = self.filePath;
    
    if (asynchronous) {
        __block NSError *err = nil;
        ATAudio *audio = self;
        [ATAsynCaller asynCallBlock:^(){
            err = [ATHelper moveFileFromPath:tmpRecordFilePath ToPath:targetFilePath];
        } Completion:^(){
            if (err) {
                [audio notifyAudio:audio FailedAsynSave:err];
            } else {
                [audio notifyAudioDidFinishAsynSave:audio];
            }
        }];
    } else {
        NSError *err = [ATHelper moveFileFromPath:tmpRecordFilePath ToPath:targetFilePath];
        result = err ? NO : YES;
    }
    
    return result;
}
- (BOOL)remove:(BOOL)asynchronous
{
    BOOL result = YES;
    
    NSString *filePath = self.filePath;
    
    if (asynchronous) {
        __block NSError *err = nil;
        ATAudio *audio = self;
        [ATAsynCaller asynCallBlock:^(){
            err = [ATHelper removeFileAtPath:filePath];
        } Completion:^(){
            if (err) {
                [audio notifyAudio:audio FailedAsynRemove:err];
            } else {
                [audio notifyAudioDidFinishAsynRemove:audio];
            }
        }];
    } else {
        NSError *err = [ATHelper removeFileAtPath:filePath];
        result = err ? NO : YES;
    }
    
    return result;
}

#pragma mark notify
- (void)notifyAudioDidFinishAsynSave:(ATAudio *)audio
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(audioDidFinishAsynSave:)]) {
        [self.delegate audioDidFinishAsynSave:audio];
    }
}
- (void)notifyAudio:(ATAudio *)audio FailedAsynSave:(NSError *)error
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(audio:FailedAsynSave:)]) {
        [self.delegate audio:audio FailedAsynSave:error];
    }
}
- (void)notifyAudioDidFinishAsynRemove:(ATAudio *)audio
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(audioDidFinishAsynRemove:)]) {
        [self.delegate audioDidFinishAsynRemove:audio];
    }
}
- (void)notifyAudio:(ATAudio *)audio FailedAsynRemove:(NSError *)error
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(audio:FailedAsynRemove:)]) {
        [self.delegate audio:audio FailedAsynRemove:error];
    }
}

@end

