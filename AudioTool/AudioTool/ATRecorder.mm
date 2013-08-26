//
//  ATRecorder.m
//  XVoice
//
//  Created by 佳佑 on 13-8-26.
//  Copyright (c) 2013年 shawnt22@gmail.com. All rights reserved.
//

#import "ATRecorder.h"
#import "AQRecorder.h"
#import "ATHelper.h"

@interface ATRecorder ()
@property (nonatomic, unsafe_unretained) AQRecorder *recorder;
@property (nonatomic, strong) ATAudio *audio;
@end

@implementation ATRecorder

#pragma mark init & dealloc
- (id)init
{
    self = [super init];
    if (self) {
        self.recorder = new AQRecorder();
    }
    return self;
}
- (void)dealloc
{
    delete self.recorder;
}

#pragma mark record
- (BOOL)start:(ATAudio *)audio
{
    self.audio = audio;
    
    if (self.recorder->IsRunning()) {
        [self cancel];
    }
    self.audio.recordTime = [[NSDate date] timeIntervalSinceNow];
    self.recorder->StartRecord(self.audio.cfFileName);
    
    return YES;
}
- (BOOL)complete:(BOOL)canceled
{
    self.recorder->StopRecord();
    self.audio.saveTime = [[NSDate date] timeIntervalSinceNow];
    return YES;
}
- (BOOL)stop
{
    return [self complete:NO];
}
- (BOOL)cancel
{
    return [self complete:YES];
}

@end
