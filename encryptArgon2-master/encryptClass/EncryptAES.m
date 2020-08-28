//
//  EncryptAES.m
//  encryptDemo
//
//  Created by kevin guo on 2020/8/7.
//  Copyright © 2020 kevin guo. All rights reserved.
//

#import "EncryptAES.h"
#import <CommonCrypto/CommonCrypto.h>
#import <CommonCrypto/CommonDigest.h>

@implementation EncryptAES
//加密
+ (NSData *)stringEncryptAES:(NSString *)content key:(NSString *)key {
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = contentData.length;
    // 为结束符'\\0' +1
    char keyPtr[kCCKeySizeAES256 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    // 密文长度 <= 明文长度 + BlockSize
    size_t encryptSize = dataLength + kCCKeySizeAES256;
    void *encryptedBytes = malloc(encryptSize);
    size_t actualOutSize = 0;
//    NSString *const kInitVector = @"1234567890123456"; //16位偏移，CBC模式才有
    NSData *initVector = [KInitVector dataUsingEncoding:NSUTF8StringEncoding];
    CCCryptorStatus cryptStatus = CCCrypt(
    kCCEncrypt,//kCCEncrypt 代表加密 kCCDecrypt代表解密
    kCCAlgorithmAES,//加密算法
    kCCOptionPKCS7Padding,  // 系统默认使用 CBC，然后指明使用 PKCS7Padding，iOS只有CBC和ECB模式，如果想使用ECB模式，可以这样编写  kCCOptionPKCS7Padding | kCCOptionECBMode
    keyPtr,//公钥
    kCCKeySizeAES256,//密钥长度256
    initVector.bytes,//偏移字符串
    contentData.bytes,//编码内容
    dataLength,//数据长度
    encryptedBytes,//加密输出缓冲区
    encryptSize,//加密输出缓冲区大小
    &actualOutSize);//实际输出大小
    if (cryptStatus == kCCSuccess) {
    // 返回编码后的数据
    return [NSData dataWithBytesNoCopy:encryptedBytes length:actualOutSize];
    }
    free(encryptedBytes);
    return nil;
}

// 解密
+ (NSData *)stringDecryptAESWithData:(NSData *)data key:(NSString *)key{
     char keyPtr[kCCKeySizeAES256 + 1];
     bzero(keyPtr, sizeof(keyPtr));
     [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
     NSUInteger dataLength = [data length];
     size_t bufferSize = dataLength + kCCKeySizeAES256;
     void *buffer = malloc(bufferSize);
     size_t numBytesDecrypted = 0;
    // NSString *const kInitVector = @"1234567890123456"; //16位偏移，CBC模式才有
     NSData *initVector = [KInitVector dataUsingEncoding:NSUTF8StringEncoding];
     //字段含义在上面加密已经解释过了，这里不做赘述
     CCCryptorStatus cryptStatus = CCCrypt(
        kCCDecrypt,
        kCCAlgorithmAES,
        kCCOptionPKCS7Padding,
        keyPtr,
        kCCKeySizeAES256,
        initVector.bytes,
        [data bytes],
        dataLength,
        buffer,
        bufferSize,
        &numBytesDecrypted);
     if(cryptStatus == kCCSuccess){
         return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
     }
     free(buffer);
     return nil;
}

+ (NSData *)dataEncryptAES:(NSData *)contentData key:(NSData *)key vector:(NSData *)vector{
        NSUInteger dataLength = contentData.length;
        // 为结束符'\\0' +1
//        char keyPtr[kCCKeySizeAES256 + 1];
//        memset(keyPtr, 0, sizeof(keyPtr));
        // 密文长度 <= 明文长度 + BlockSize
        size_t encryptSize = dataLength + kCCKeySizeAES256;
        void *encryptedBytes = malloc(encryptSize);
        size_t actualOutSize = 0;
        CCCryptorStatus cryptStatus = CCCrypt(
        kCCEncrypt,//kCCEncrypt 代表加密 kCCDecrypt代表解密
        kCCAlgorithmAES,//加密算法
        kCCOptionPKCS7Padding,  // 系统默认使用 CBC，然后指明使用 PKCS7Padding，iOS只有CBC和ECB模式，如果想使用ECB模式，可以这样编写  kCCOptionPKCS7Padding | kCCOptionECBMode
        key.bytes,//公钥
        kCCKeySizeAES256,//密钥长度256
        vector.bytes,//偏移字符串
        contentData.bytes,//编码内容
        dataLength,//数据长度
        encryptedBytes,//加密输出缓冲区
        encryptSize,//加密输出缓冲区大小
        &actualOutSize);//实际输出大小
        if (cryptStatus == kCCSuccess) {
        // 返回编码后的数据
        return [NSData dataWithBytesNoCopy:encryptedBytes length:actualOutSize];
        }
        free(encryptedBytes);
        return nil;
}

+ (NSData *)dataDecryptAESWithData:(NSData *)data key:(NSData *)key vector:(NSData *)vector{
     NSUInteger dataLength = [data length];
     size_t bufferSize = dataLength + kCCKeySizeAES256;
     void *buffer = malloc(bufferSize);
     size_t numBytesDecrypted = 0;
    // NSString *const kInitVector = @"1234567890123456"; //16位偏移，CBC模式才有
//     NSData *initVector = [KInitVector dataUsingEncoding:NSUTF8StringEncoding];
     CCCryptorStatus cryptStatus = CCCrypt(
        kCCDecrypt,
        kCCAlgorithmAES,
        kCCOptionPKCS7Padding,
        key.bytes,
        kCCKeySizeAES256,
        vector.bytes,
        [data bytes],
        dataLength,
        buffer,
        bufferSize,
        &numBytesDecrypted);
     if(cryptStatus == kCCSuccess){
         return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
     }
     free(buffer);
     return nil;
}

@end
