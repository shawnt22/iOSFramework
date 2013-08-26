//
//  ATPlayer.h
//  XVoice
//
//  Created by 佳佑 on 13-8-26.
//  Copyright (c) 2013年 shawnt22@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATAudio.h"

@interface ATPlayer : NSObject
@property (nonatomic, readonly) ATAudio *audio;

- (BOOL)start:(ATAudio *)audio;
- (BOOL)stop;
- (BOOL)pause;
- (BOOL)resume;

@end

