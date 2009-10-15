//
//  SZURLConnection.h
//
//  Created by Jon Nall on 10/9/09.
//  Copyright 2009 STUNTAZ!!!. All rights reserved.
// 
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//  
//  Redistributions of source code must retain the above copyright notice, this
//  list of conditions and the following disclaimer.
//
//  Redistributions in binary form must reproduce the above copyright notice, 
//  this list of conditions and the following disclaimer in the documentation 
//  and/or other materials provided with the distribution.
//  
//  Neither the name of Jon Nall  nor the names of its contributors may be used 
//  to endorse or promote products derived from this software without specific 
//  prior written permission. 
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE 
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
//  POSSIBILITY OF SUCH DAMAGE.
//
//  SZHTTPURLResponse uses code found In the connection framework
//  http://opensource.utr-software.com/connection/
//  Which is licensed under the BSD license
//  Copyright 2009 Karelia Software. All rights reserved.
//


#import <Foundation/Foundation.h>

// There is no public API to create an NSHTTPResponse, so subclass it and
// return this instance
@interface SZHTTPURLResponse : NSHTTPURLResponse
{
    @private
    NSInteger _statusCode;
    NSDictionary* _headerFields;
}
@end

@class SZURLConnection;

@protocol SZURLConnectionDelegate
@optional
-(void)szConnection:(SZURLConnection*)connection
 didReceiveResponse:(NSURLResponse*)response;

-(void)szConnection:(SZURLConnection*)connection
     didReceiveData:(NSData*)data;

-(void)szConnectionDidFinishLoading:(SZURLConnection*)connection;

-(void)szConnection:(SZURLConnection*)connection
   didFailWithError:(NSError*)error;
@end

@interface SZURLConnection : NSObject
{
    NSObject<SZURLConnectionDelegate>* _delegate;
    NSUInteger _minimumDataSize;
    
    NSURLRequest* _request;
    
    CFReadStreamRef _cfStream;
    
    BOOL _sentResponse;
    NSMutableData* _currentData;
}
@property (retain) id delegate;
@property (assign) NSUInteger minimumDataSize;

-(id)initWithRequest:(NSURLRequest*)request
            delegate:(id)delegate
    startImmediately:(BOOL)startImmediately;

-(id)initWithRequest:(NSURLRequest*)request
            delegate:(id)delegate;

-(void)start;

-(void)cancel;

-(void)szConnection:(SZURLConnection*)connection
didReceiveResponse:(NSURLResponse*)response;

-(void)szConnection:(SZURLConnection*)connection
   didReceiveData:(NSData*)data;

-(void)szConnectionDidFinishLoading:(SZURLConnection*)connection;

-(void)szConnection:(SZURLConnection*)connection
 didFailWithError:(NSError*)error;

@end
