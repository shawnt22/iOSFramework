//
//  ATPlayer.m
//  XVoice
//
//  Created by 佳佑 on 13-8-26.
//  Copyright (c) 2013年 shawnt22@gmail.com. All rights reserved.
//

#import "ATPlayer.h"
#import "AQPlayer.h"
#import "ATDefine.h"

@interface ATPlayer ()
@property (nonatomic, unsafe_unretained) AQPlayer *player;
@property (nonatomic, unsafe_unretained) BOOL isPaused;
@property (nonatomic, strong) ATAudio *audio;
@end

@implementation ATPlayer

#pragma mark init & dealloc
- (id)init
{
    self = [super init];
    if (self) {
        self.player = new AQPlayer();
    }
    return self;
}
- (void)dealloc
{
    delete self.player;
}

#pragma mark play
- (BOOL)prepare:(ATAudio *)audio
{
    BOOL result = YES;
    if (self.player->IsRunning()) {
        result = [self stop];
    }
    
    self.audio = audio;
    if (result) {
        self.player->DisposeQueue(true);
        self.player->CreateQueueForFile(audio.cfFilePath);
    }
    
    return result;
}
- (BOOL)start:(ATAudio *)audio
{
    BOOL result = YES;
    result = [self prepare:audio];
    
    if (result) {
        OSStatus status = self.player->StartQueue(false);
        result = status == noErr ? YES : NO;
    }
    
    return result;
}
- (BOOL)stop
{
    OSStatus status = self.player->StopQueue();
    return status == noErr ? YES : NO;
}
- (BOOL)pause
{
    OSStatus status = self.player->PauseQueue();
    if (status == noErr) {
        self.isPaused = YES;
        return YES;
    } else {
        return NO;
    }
}
- (BOOL)resume
{
    OSStatus status = self.player->StartQueue(true);
    return status == noErr ? YES : NO;
}

@end
