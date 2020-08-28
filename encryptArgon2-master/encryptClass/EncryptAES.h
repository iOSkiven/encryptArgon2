//
//  EncryptAES.h
//  encryptDemo
//
//  Created by kevin guo on 2020/8/7.
//  Copyright © 2020 kevin guo. All rights reserved.
//

#import <Foundation/Foundation.h>
//16位偏移，CBC模式才有
#define KInitVector @"1234567890123456"

NS_ASSUME_NONNULL_BEGIN

@interface EncryptAES : NSObject
//AES加密
+ (NSData *)stringEncryptAES:(NSString *)content key:(NSString *)key;
//AES解密
+ (NSData *)stringDecryptAESWithData:(NSData *)data key:(NSString *)key;
//AES加密
+ (NSData *)dataEncryptAES:(NSData *)contentData key:(NSData *)key vector:(NSData *)vector;
//AES解密
+ (NSData *)dataDecryptAESWithData:(NSData *)data key:(NSData *)key vector:(NSData *)vector;

@end

NS_ASSUME_NONNULL_END
