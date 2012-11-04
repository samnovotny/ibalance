//
//  machine.m
//  iBalance
//
//  Created by Sam on 27/12/2009.
//  Copyright 2009 Sam Novotny. All rights reserved.
//

#import "machine.h"


@implementation Machine

- (id) init {
	self = [super init];
	_maxWeight = 2500;
	_armFrontPax = 49.5;
	_armFrontBaggage = 44.0;
	_armRearPax = 79.5;
	_armMainFuel = 106.0;
	_armAuxFuel = 102.0;
	return self;
}

- (id) setWithName:(NSString *) n weight:(float) w moment:(float) m {
	self = [self init];
	self.name = n;
	self.emptyWeight = w;
	self.moment = m;
	self.armCOG = m / self.emptyWeight;
	return self;
}

- (void) encodeWithCoder:(NSCoder *) encoder {
	[encoder encodeObject:self.name forKey:kFieldName];
	[encoder encodeFloat:self.emptyWeight forKey:kFieldEmptyWeight];
	[encoder encodeFloat:self.moment forKey:kFieldMoment];
}

- (id) initWithCoder:(NSCoder *)aDecoder {
	if (self = [self init]) {
		self.name = [aDecoder decodeObjectForKey:kFieldName];
		self.emptyWeight = [aDecoder decodeFloatForKey:kFieldEmptyWeight];
		self.moment = [aDecoder decodeFloatForKey:kFieldMoment];
		self.armCOG = self.moment / self.emptyWeight;
	}
	return self;
}

@end
