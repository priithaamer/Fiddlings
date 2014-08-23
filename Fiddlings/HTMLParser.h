//
//  HTMLParser.h
//  Fiddlings
//
//  Created by Priit Haamer on 23.08.14.
//  Copyright (c) 2014 Priit Haamer. All rights reserved.
//

#ifndef Fiddlings_HTMLParser_h
#define Fiddlings_HTMLParser_h

#import <PEGKit/PKParser.h>

enum {
    HTMLPARSER_TOKEN_KIND_SCRIPTTAGNAME = 14,
    HTMLPARSER_TOKEN_KIND_STYLETAGNAME,
    HTMLPARSER_TOKEN_KIND_DOCTYPE,
    HTMLPARSER_TOKEN_KIND_LT,
    HTMLPARSER_TOKEN_KIND_PROCINSTR,
    HTMLPARSER_TOKEN_KIND_EQ,
    HTMLPARSER_TOKEN_KIND_FWDSLASH,
    HTMLPARSER_TOKEN_KIND_GT,
};

@interface HTMLParser : PKParser

@end

#endif
