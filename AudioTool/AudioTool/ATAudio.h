//
//  ATAudio.h
//  XVoice
//
//  Created by 佳佑 on 13-8-26.
//  Copyright (c) 2013年 shawnt22@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ATAudio;
@protocol ATAudioDelegate <NSObject>
@optional
- (void)audioDidFinishAsynSave:(ATAudio *)audio;
- (void)audio:(ATAudio *)audio FailedAsynSave:(NSError *)error;
- (void)audioDidFinishAsynRemove:(ATAudio *)audio;
- (void)audio:(ATAudio *)audio FailedAsynRemove:(NSError *)error;
@end

@interface ATAudio : NSObject <NSCoding>
@property (nonatomic, weak) id<ATAudioDelegate> delegate;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, unsafe_unretained) NSTimeInterval recordTime; //  开始录制的时间
@property (nonatomic, unsafe_unretained) NSTimeInterval saveTime;   //  保存到本地的时间

@property (nonatomic, readonly) NSString *filePath;
@property (nonatomic, readonly) CFStringRef cfFileName;
@property (nonatomic, readonly) CFStringRef cfFilePath;

- (BOOL)save:(BOOL)asynchronous;
- (BOOL)remove:(BOOL)asynchronous;

@end
