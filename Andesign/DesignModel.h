//
//  DesignModel.h
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/4/18.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DesignModel : NSObject

@property (nonatomic, copy) NSNumber *designId;
@property (nonatomic, copy) NSData *mainImg;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *detailText;

@end
