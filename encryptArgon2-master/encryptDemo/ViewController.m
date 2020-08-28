//
//  ViewController.m
//  encryptDemo
//
//  Created by kevin guo on 2020/8/5.
//  Copyright © 2020 kevin guo. All rights reserved.
//

#import "ViewController.h"
#import "EncryptAES.h"
#import "EncryptArgon2.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSData *encryptData = [EncryptAES stringEncryptAES:@"12345678asdfghjk" key:@"11111111111111112222222222222222"];
//    NSLog(@"data = %@",encryptData.description);
//    NSData *decryptData = [EncryptAES stringDecryptAESWithData:encryptData key:@"11111111111111112222222222222222"];
//    NSUInteger len = [encryptData length];
//    Byte *byteData1 = (Byte*)malloc(len);
//    memcpy(byteData1, [encryptData bytes], len);
//    for (int i=0; i<encryptData.length;i++){
//        printf("%02x", byteData1[i]);
//    }
//    printf("\n");
//    NSString * str  =[[NSString alloc] initWithData:decryptData encoding:NSUTF8StringEncoding];
//    NSLog(@"dedata = %@",str);
//
//    NSString *keyStr1 = @"password";
//    NSData *keyData1 = [keyStr1 dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *a = [EncryptArgon2 argon2iEncode:32 mCost:16 parallelism:1 pwdData:keyData1 abufLenth:32];
//    NSLog(@"a   =   %@",a.description);
    NSString *str = @"34567uiuhgfxcvghjytfrdxcvbnhgfdfgh";
    NSData *strData1 = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSString *vec = @"1234567890123456";
    NSData *vecData1 = [vec dataUsingEncoding:NSUTF8StringEncoding];
    NSString *key = @"4gfhyuuijbftyuiui8766444578";
    NSData *keyData1 = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encode = [EncryptAES dataEncryptAES:strData1 key:keyData1 vector:vecData1];
    NSLog(@"======encode = %@",encode.description);
    NSData *decode = [EncryptAES dataDecryptAESWithData:encode key:keyData1 vector:vecData1];
    NSLog(@"======decode = %@",decode.description);
}


@end
