//
//  EncryptArgon2.m
//  encryptDemo
//
//  Created by kevin guo on 2020/8/27.
//  Copyright © 2020 kevin guo. All rights reserved.
//

#import "EncryptArgon2.h"
#import "argon2.h"

@implementation EncryptArgon2
/**
*  Argon2加密算法
*
*  @param t_cost  Number of iterations
*  @param m_cost  Sets memory usage to m_cost kibibytes
*  @param parallelism  Number of threads and compute lanes
*  @param pwdData  Pointer to password
*  @param lenth  Desired length of the hash in bytes
*  @return   after encrypted data
*
*/
+(NSData *)argon2iEncode:(int)t_cost mCost:(int )m_cost parallelism:(int)parallelism pwdData:(NSData *)pwdData abufLenth:(int)lenth{
    NSUInteger len = [pwdData length];
    Byte *byteData = (Byte*)malloc(len);
    memcpy(byteData, [pwdData bytes], len);
    Byte *abuf = (Byte*)malloc(lenth);
    NSInteger result = argon2i_hash_raw(t_cost, m_cost, parallelism, byteData, len, byteData, len, abuf, lenth);
    int i;
    printf("---------------encode------------");
    printf("\n");
    for (i = 0; i < lenth; i++)
        printf("%02x", abuf[i]);
    printf("\n");
    if (result == 0) {
        NSData *returnData = [[NSData alloc] initWithBytes:abuf length:lenth];
        return returnData;
    }
    return nil;
    
}

@end
