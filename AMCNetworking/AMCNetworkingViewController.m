//
//  AMCNetworkingViewController.m
//  AMCNetworking
//
//  Created by dynamsoft on 19/05/2017.
//  Copyright © 2017 dynamsoft. All rights reserved.
//

#import "AMCNetworkingViewController.h"
#import <CFNetwork/CFNetwork.h>

@interface AMCNetworkingViewController ()

@end

@implementation AMCNetworkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)networkActionTest{
    CFStringRef headerFieldName = CFSTR("this is a header");
    CFStringRef headerFieldValue = CFSTR("value");
    //创建url
    CFStringRef url1 = CFSTR("http://c.hiphotos.baidu.com/image/w%3D310/sign=b8f7695888d4b31cf03c92bab7d6276f/4e4a20a4462309f76248df09710e0cf3d7cad682.jpg");
    CFURLRef myURL = CFURLCreateWithString(kCFAllocatorDefault, url1, NULL);
    //设置请求方式
    CFStringRef requestMethod = CFSTR("GET");
    //创建请求
    CFHTTPMessageRef myRequest = CFHTTPMessageCreateRequest(kCFAllocatorDefault,requestMethod, myURL, kCFHTTPVersion1_1);
    //设置头信息
    CFHTTPMessageSetHeaderFieldValue(myRequest, headerFieldName, headerFieldValue);
    //创建CFReadStreamRef对象来序列化并发送CFHTTP请求，注意CFReadStreamCreateForHTTPRequest在iOS 9.0开始已经有DEPRECATED警告，
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CFReadStreamRef myReadStream = CFReadStreamCreateForHTTPRequest(kCFAllocatorDefault, myRequest);
    #pragma clang diagnostic pop
    //打开读取流
    CFReadStreamOpen(myReadStream);
    //存放响应数据
    NSMutableData *responseBytes = [NSMutableData data];
    CFIndex numBytesRead = 0;
    //从流中读取数据,读完为止，其中CFReadStreamRead会阻塞代码
    do {
        UInt8 buf[1024];
        numBytesRead = CFReadStreamRead(myReadStream, buf, sizeof(buf));
        
        if (numBytesRead > 0) {
            [responseBytes appendBytes:buf length:numBytesRead];
        }
    } while (numBytesRead > 0);
    //读取响应头信息
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CFHTTPMessageRef myResponse = (CFHTTPMessageRef) CFReadStreamCopyProperty(myReadStream, kCFStreamPropertyHTTPResponseHeader);
    #pragma clang diagnostic pop
    //读取statusCode
    CFIndex statusCode = CFHTTPMessageGetResponseStatusCode(myResponse);
    //打印数据
    if(statusCode == 200) {
        //NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseBytes options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@", responseBytes);
    }
}

@end
