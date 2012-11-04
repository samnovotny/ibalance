//
//  machine.h
//  iBalance
//
//  Created by Sam on 27/12/2009.
//  Copyright 2009 Sam Novotny. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kFieldName			@"name"
#define kFieldEmptyWeight	@"emptyWeight"
#define kFieldMoment		@"armMoment"

@interface Machine : NSObject <NSCoding>

@property (nonatomic, retain) NSString *name;
@property (nonatomic) float emptyWeight;
@property (nonatomic) float maxWeight;
@property (nonatomic) float moment;
@property (nonatomic) float armCOG;
@property (nonatomic) float armFrontPax;
@property (nonatomic) float armFrontBaggage;
@property (nonatomic) float armRearPax;
@property (nonatomic) float armMainFuel;
@property (nonatomic) float armAuxFuel;

- (id) init;
- (id) setWithName:(NSString *) n weight:(float) w moment:(float) m;

@end
