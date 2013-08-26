//
//  ATDefine.h
//  XVoice
//
//  Created by 佳佑 on 13-8-26.
//  Copyright (c) 2013年 shawnt22@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Error
static NSString *AT_ERROR_DOMAIN = @"at_error_domain";
typedef enum {
    ATErrorUnknown,
    ATErrorPramsWronge,
    ATErrorSaveFileExisted,
    ATErrorRecordFail,
}ATErrorCode;