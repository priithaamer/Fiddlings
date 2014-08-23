#import "HTMLParser.h"
#import <PEGKit/PEGKit.h>


@interface HTMLParser ()

@property (nonatomic, retain) NSMutableDictionary *start_memo;
@property (nonatomic, retain) NSMutableDictionary *anything_memo;
@property (nonatomic, retain) NSMutableDictionary *scriptElement_memo;
@property (nonatomic, retain) NSMutableDictionary *scriptStartTag_memo;
@property (nonatomic, retain) NSMutableDictionary *scriptEndTag_memo;
@property (nonatomic, retain) NSMutableDictionary *scriptTagName_memo;
@property (nonatomic, retain) NSMutableDictionary *scriptElementContent_memo;
@property (nonatomic, retain) NSMutableDictionary *styleElement_memo;
@property (nonatomic, retain) NSMutableDictionary *styleStartTag_memo;
@property (nonatomic, retain) NSMutableDictionary *styleEndTag_memo;
@property (nonatomic, retain) NSMutableDictionary *styleTagName_memo;
@property (nonatomic, retain) NSMutableDictionary *styleElementContent_memo;
@property (nonatomic, retain) NSMutableDictionary *procInstr_memo;
@property (nonatomic, retain) NSMutableDictionary *doctype_memo;
@property (nonatomic, retain) NSMutableDictionary *text_memo;
@property (nonatomic, retain) NSMutableDictionary *tag_memo;
@property (nonatomic, retain) NSMutableDictionary *emptyTag_memo;
@property (nonatomic, retain) NSMutableDictionary *startTag_memo;
@property (nonatomic, retain) NSMutableDictionary *endTag_memo;
@property (nonatomic, retain) NSMutableDictionary *tagName_memo;
@property (nonatomic, retain) NSMutableDictionary *attr_memo;
@property (nonatomic, retain) NSMutableDictionary *attrName_memo;
@property (nonatomic, retain) NSMutableDictionary *attrValue_memo;
@property (nonatomic, retain) NSMutableDictionary *eq_memo;
@property (nonatomic, retain) NSMutableDictionary *lt_memo;
@property (nonatomic, retain) NSMutableDictionary *gt_memo;
@property (nonatomic, retain) NSMutableDictionary *fwdSlash_memo;
@property (nonatomic, retain) NSMutableDictionary *comment_memo;
@end

@implementation HTMLParser { }

- (instancetype)initWithDelegate:(id)d {
    self = [super initWithDelegate:d];
    if (self) {
        
        self.startRuleName = @"start";
        self.enableAutomaticErrorRecovery = YES;
        
        self.tokenKindTab[@"script"] = @(HTMLPARSER_TOKEN_KIND_SCRIPTTAGNAME);
        self.tokenKindTab[@"style"] = @(HTMLPARSER_TOKEN_KIND_STYLETAGNAME);
        self.tokenKindTab[@"<!DOCTYPE,>"] = @(HTMLPARSER_TOKEN_KIND_DOCTYPE);
        self.tokenKindTab[@"<"] = @(HTMLPARSER_TOKEN_KIND_LT);
        self.tokenKindTab[@"<?,?>"] = @(HTMLPARSER_TOKEN_KIND_PROCINSTR);
        self.tokenKindTab[@"="] = @(HTMLPARSER_TOKEN_KIND_EQ);
        self.tokenKindTab[@"/"] = @(HTMLPARSER_TOKEN_KIND_FWDSLASH);
        self.tokenKindTab[@">"] = @(HTMLPARSER_TOKEN_KIND_GT);
        
        self.tokenKindNameTab[HTMLPARSER_TOKEN_KIND_SCRIPTTAGNAME] = @"script";
        self.tokenKindNameTab[HTMLPARSER_TOKEN_KIND_STYLETAGNAME] = @"style";
        self.tokenKindNameTab[HTMLPARSER_TOKEN_KIND_DOCTYPE] = @"<!DOCTYPE,>";
        self.tokenKindNameTab[HTMLPARSER_TOKEN_KIND_LT] = @"<";
        self.tokenKindNameTab[HTMLPARSER_TOKEN_KIND_PROCINSTR] = @"<?,?>";
        self.tokenKindNameTab[HTMLPARSER_TOKEN_KIND_EQ] = @"=";
        self.tokenKindNameTab[HTMLPARSER_TOKEN_KIND_FWDSLASH] = @"/";
        self.tokenKindNameTab[HTMLPARSER_TOKEN_KIND_GT] = @">";
        
        self.start_memo = [NSMutableDictionary dictionary];
        self.anything_memo = [NSMutableDictionary dictionary];
        self.scriptElement_memo = [NSMutableDictionary dictionary];
        self.scriptStartTag_memo = [NSMutableDictionary dictionary];
        self.scriptEndTag_memo = [NSMutableDictionary dictionary];
        self.scriptTagName_memo = [NSMutableDictionary dictionary];
        self.scriptElementContent_memo = [NSMutableDictionary dictionary];
        self.styleElement_memo = [NSMutableDictionary dictionary];
        self.styleStartTag_memo = [NSMutableDictionary dictionary];
        self.styleEndTag_memo = [NSMutableDictionary dictionary];
        self.styleTagName_memo = [NSMutableDictionary dictionary];
        self.styleElementContent_memo = [NSMutableDictionary dictionary];
        self.procInstr_memo = [NSMutableDictionary dictionary];
        self.doctype_memo = [NSMutableDictionary dictionary];
        self.text_memo = [NSMutableDictionary dictionary];
        self.tag_memo = [NSMutableDictionary dictionary];
        self.emptyTag_memo = [NSMutableDictionary dictionary];
        self.startTag_memo = [NSMutableDictionary dictionary];
        self.endTag_memo = [NSMutableDictionary dictionary];
        self.tagName_memo = [NSMutableDictionary dictionary];
        self.attr_memo = [NSMutableDictionary dictionary];
        self.attrName_memo = [NSMutableDictionary dictionary];
        self.attrValue_memo = [NSMutableDictionary dictionary];
        self.eq_memo = [NSMutableDictionary dictionary];
        self.lt_memo = [NSMutableDictionary dictionary];
        self.gt_memo = [NSMutableDictionary dictionary];
        self.fwdSlash_memo = [NSMutableDictionary dictionary];
        self.comment_memo = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)clearMemo {
    [_start_memo removeAllObjects];
    [_anything_memo removeAllObjects];
    [_scriptElement_memo removeAllObjects];
    [_scriptStartTag_memo removeAllObjects];
    [_scriptEndTag_memo removeAllObjects];
    [_scriptTagName_memo removeAllObjects];
    [_scriptElementContent_memo removeAllObjects];
    [_styleElement_memo removeAllObjects];
    [_styleStartTag_memo removeAllObjects];
    [_styleEndTag_memo removeAllObjects];
    [_styleTagName_memo removeAllObjects];
    [_styleElementContent_memo removeAllObjects];
    [_procInstr_memo removeAllObjects];
    [_doctype_memo removeAllObjects];
    [_text_memo removeAllObjects];
    [_tag_memo removeAllObjects];
    [_emptyTag_memo removeAllObjects];
    [_startTag_memo removeAllObjects];
    [_endTag_memo removeAllObjects];
    [_tagName_memo removeAllObjects];
    [_attr_memo removeAllObjects];
    [_attrName_memo removeAllObjects];
    [_attrValue_memo removeAllObjects];
    [_eq_memo removeAllObjects];
    [_lt_memo removeAllObjects];
    [_gt_memo removeAllObjects];
    [_fwdSlash_memo removeAllObjects];
    [_comment_memo removeAllObjects];
}

- (void)start {
    
    [self tryAndRecover:TOKEN_KIND_BUILTIN_EOF block:^{
        [self start_];
        [self matchEOF:YES];
    } completion:^{
        [self matchEOF:YES];
    }];
    
}

- (void)__start {
    
    [self execute:^{
        
        PKTokenizer *t = self.tokenizer;
        
        // whitespace
        //    self.silentlyConsumesWhitespace = YES;
        //    t.whitespaceState.reportsWhitespaceTokens = YES;
        //    self.assembly.preservesWhitespaceTokens = YES;
        
        // symbols
        [t.symbolState add:@"<!--"];
        [t.symbolState add:@"-->"];
        [t.symbolState add:@"<?"];
        [t.symbolState add:@"?>"];
        
        // comments
        [t setTokenizerState:t.commentState from:'<' to:'<'];
        [t.commentState addMultiLineStartMarker:@"<!--" endMarker:@"-->"];
        [t.commentState setFallbackState:t.delimitState from:'<' to:'<'];
        t.commentState.reportsCommentTokens = YES;
        
        // pi
        [t.delimitState addStartMarker:@"<?" endMarker:@"?>" allowedCharacterSet:nil];
        
        // doctype
        [t.delimitState addStartMarker:@"<!DOCTYPE" endMarker:@">" allowedCharacterSet:nil];
        
        [t.delimitState setFallbackState:t.symbolState from:'<' to:'<'];
        
    }];
    while ([self speculate:^{ [self anything_]; }]) {
        [self anything_];
    }
    
    [self fireDelegateSelector:@selector(parser:didMatchStart:)];
}

- (void)start_ {
    [self parseRule:@selector(__start) withMemo:_start_memo];
}

- (void)__anything {
    
    if ([self speculate:^{ [self scriptElement_]; }]) {
        [self scriptElement_];
    } else if ([self speculate:^{ [self styleElement_]; }]) {
        [self styleElement_];
    } else if ([self speculate:^{ [self tag_]; }]) {
        [self tag_];
    } else if ([self speculate:^{ [self procInstr_]; }]) {
        [self procInstr_];
    } else if ([self speculate:^{ [self comment_]; }]) {
        [self comment_];
    } else if ([self speculate:^{ [self doctype_]; }]) {
        [self doctype_];
    } else if ([self speculate:^{ [self text_]; }]) {
        [self text_];
    } else {
        [self raise:@"No viable alternative found in rule 'anything'."];
    }
    
    [self fireDelegateSelector:@selector(parser:didMatchAnything:)];
}

- (void)anything_ {
    [self parseRule:@selector(__anything) withMemo:_anything_memo];
}

- (void)__scriptElement {
    
    [self scriptStartTag_];
    [self scriptElementContent_];
    [self scriptEndTag_];
    
    [self fireDelegateSelector:@selector(parser:didMatchScriptElement:)];
}

- (void)scriptElement_ {
    [self parseRule:@selector(__scriptElement) withMemo:_scriptElement_memo];
}

- (void)__scriptStartTag {
    
    [self lt_];
    [self tryAndRecover:HTMLPARSER_TOKEN_KIND_SCRIPTTAGNAME block:^{
        [self scriptTagName_];
    } completion:^{
        [self scriptTagName_];
    }];
    [self tryAndRecover:HTMLPARSER_TOKEN_KIND_GT block:^{
        while ([self speculate:^{ [self attr_]; }]) {
            [self attr_];
        }
        [self gt_];
    } completion:^{
        [self gt_];
    }];
    
    [self fireDelegateSelector:@selector(parser:didMatchScriptStartTag:)];
}

- (void)scriptStartTag_ {
    [self parseRule:@selector(__scriptStartTag) withMemo:_scriptStartTag_memo];
}

- (void)__scriptEndTag {
    
    [self lt_];
    [self tryAndRecover:HTMLPARSER_TOKEN_KIND_FWDSLASH block:^{
        [self fwdSlash_];
    } completion:^{
        [self fwdSlash_];
    }];
    [self tryAndRecover:HTMLPARSER_TOKEN_KIND_SCRIPTTAGNAME block:^{
        [self scriptTagName_];
    } completion:^{
        [self scriptTagName_];
    }];
    [self tryAndRecover:HTMLPARSER_TOKEN_KIND_GT block:^{
        [self gt_];
    } completion:^{
        [self gt_];
    }];
    
    [self fireDelegateSelector:@selector(parser:didMatchScriptEndTag:)];
}

- (void)scriptEndTag_ {
    [self parseRule:@selector(__scriptEndTag) withMemo:_scriptEndTag_memo];
}

- (void)__scriptTagName {
    
    [self match:HTMLPARSER_TOKEN_KIND_SCRIPTTAGNAME discard:NO];
    
    [self fireDelegateSelector:@selector(parser:didMatchScriptTagName:)];
}

- (void)scriptTagName_ {
    [self parseRule:@selector(__scriptTagName) withMemo:_scriptTagName_memo];
}

- (void)__scriptElementContent {
    
    if (![self speculate:^{ [self scriptEndTag_]; }]) {
        [self match:TOKEN_KIND_BUILTIN_ANY discard:NO];
    } else {
        [self raise:@"negation test failed in scriptElementContent"];
    }
    
    [self fireDelegateSelector:@selector(parser:didMatchScriptElementContent:)];
}

- (void)scriptElementContent_ {
    [self parseRule:@selector(__scriptElementContent) withMemo:_scriptElementContent_memo];
}

- (void)__styleElement {
    
    [self styleStartTag_];
    [self styleElementContent_];
    [self styleEndTag_];
    
    [self fireDelegateSelector:@selector(parser:didMatchStyleElement:)];
}

- (void)styleElement_ {
    [self parseRule:@selector(__styleElement) withMemo:_styleElement_memo];
}

- (void)__styleStartTag {
    
    [self lt_];
    [self tryAndRecover:HTMLPARSER_TOKEN_KIND_STYLETAGNAME block:^{
        [self styleTagName_];
    } completion:^{
        [self styleTagName_];
    }];
    [self tryAndRecover:HTMLPARSER_TOKEN_KIND_GT block:^{
        while ([self speculate:^{ [self attr_]; }]) {
            [self attr_];
        }
        [self gt_];
    } completion:^{
        [self gt_];
    }];
    
    [self fireDelegateSelector:@selector(parser:didMatchStyleStartTag:)];
}

- (void)styleStartTag_ {
    [self parseRule:@selector(__styleStartTag) withMemo:_styleStartTag_memo];
}

- (void)__styleEndTag {
    
    [self lt_];
    [self tryAndRecover:HTMLPARSER_TOKEN_KIND_FWDSLASH block:^{
        [self fwdSlash_];
    } completion:^{
        [self fwdSlash_];
    }];
    [self tryAndRecover:HTMLPARSER_TOKEN_KIND_STYLETAGNAME block:^{
        [self styleTagName_];
    } completion:^{
        [self styleTagName_];
    }];
    [self tryAndRecover:HTMLPARSER_TOKEN_KIND_GT block:^{
        [self gt_];
    } completion:^{
        [self gt_];
    }];
    
    [self fireDelegateSelector:@selector(parser:didMatchStyleEndTag:)];
}

- (void)styleEndTag_ {
    [self parseRule:@selector(__styleEndTag) withMemo:_styleEndTag_memo];
}

- (void)__styleTagName {
    
    [self match:HTMLPARSER_TOKEN_KIND_STYLETAGNAME discard:NO];
    
    [self fireDelegateSelector:@selector(parser:didMatchStyleTagName:)];
}

- (void)styleTagName_ {
    [self parseRule:@selector(__styleTagName) withMemo:_styleTagName_memo];
}

- (void)__styleElementContent {
    
    if (![self speculate:^{ [self styleEndTag_]; }]) {
        [self match:TOKEN_KIND_BUILTIN_ANY discard:NO];
    } else {
        [self raise:@"negation test failed in styleElementContent"];
    }
    
    [self fireDelegateSelector:@selector(parser:didMatchStyleElementContent:)];
}

- (void)styleElementContent_ {
    [self parseRule:@selector(__styleElementContent) withMemo:_styleElementContent_memo];
}

- (void)__procInstr {
    
    [self match:HTMLPARSER_TOKEN_KIND_PROCINSTR discard:NO];
    
    [self fireDelegateSelector:@selector(parser:didMatchProcInstr:)];
}

- (void)procInstr_ {
    [self parseRule:@selector(__procInstr) withMemo:_procInstr_memo];
}

- (void)__doctype {
    
    [self match:HTMLPARSER_TOKEN_KIND_DOCTYPE discard:NO];
    
    [self fireDelegateSelector:@selector(parser:didMatchDoctype:)];
}

- (void)doctype_ {
    [self parseRule:@selector(__doctype) withMemo:_doctype_memo];
}

- (void)__text {
    
    [self matchAny:NO];
    
    [self fireDelegateSelector:@selector(parser:didMatchText:)];
}

- (void)text_ {
    [self parseRule:@selector(__text) withMemo:_text_memo];
}

- (void)__tag {
    
    if ([self speculate:^{ [self emptyTag_]; }]) {
        [self emptyTag_];
    } else if ([self speculate:^{ [self startTag_]; }]) {
        [self startTag_];
    } else if ([self speculate:^{ [self endTag_]; }]) {
        [self endTag_];
    } else {
        [self raise:@"No viable alternative found in rule 'tag'."];
    }
    
    [self fireDelegateSelector:@selector(parser:didMatchTag:)];
}

- (void)tag_ {
    [self parseRule:@selector(__tag) withMemo:_tag_memo];
}

- (void)__emptyTag {
    
    [self lt_];
    [self tryAndRecover:HTMLPARSER_TOKEN_KIND_FWDSLASH block:^{
        [self tagName_];
        while ([self speculate:^{ [self attr_]; }]) {
            [self attr_];
        }
        [self fwdSlash_];
    } completion:^{
        [self fwdSlash_];
    }];
    [self tryAndRecover:HTMLPARSER_TOKEN_KIND_GT block:^{
        [self gt_];
    } completion:^{
        [self gt_];
    }];
    
    [self fireDelegateSelector:@selector(parser:didMatchEmptyTag:)];
}

- (void)emptyTag_ {
    [self parseRule:@selector(__emptyTag) withMemo:_emptyTag_memo];
}

- (void)__startTag {
    
    [self lt_];
    [self tryAndRecover:HTMLPARSER_TOKEN_KIND_GT block:^{
        [self tagName_];
        while ([self speculate:^{ [self attr_]; }]) {
            [self attr_];
        }
        [self gt_];
    } completion:^{
        [self gt_];
    }];
    
    [self fireDelegateSelector:@selector(parser:didMatchStartTag:)];
}

- (void)startTag_ {
    [self parseRule:@selector(__startTag) withMemo:_startTag_memo];
}

- (void)__endTag {
    
    [self lt_];
    [self tryAndRecover:HTMLPARSER_TOKEN_KIND_FWDSLASH block:^{
        [self fwdSlash_];
    } completion:^{
        [self fwdSlash_];
    }];
    [self tryAndRecover:HTMLPARSER_TOKEN_KIND_GT block:^{
        [self tagName_];
        [self gt_];
    } completion:^{
        [self gt_];
    }];
    
    [self fireDelegateSelector:@selector(parser:didMatchEndTag:)];
}

- (void)endTag_ {
    [self parseRule:@selector(__endTag) withMemo:_endTag_memo];
}

- (void)__tagName {
    
    [self matchWord:NO];
    
    [self fireDelegateSelector:@selector(parser:didMatchTagName:)];
}

- (void)tagName_ {
    [self parseRule:@selector(__tagName) withMemo:_tagName_memo];
}

- (void)__attr {
    
    [self attrName_];
    if ([self speculate:^{ [self eq_]; if ([self predicts:TOKEN_KIND_BUILTIN_QUOTEDSTRING, TOKEN_KIND_BUILTIN_WORD, 0]) {[self attrValue_]; }}]) {
        [self eq_];
        if ([self predicts:TOKEN_KIND_BUILTIN_QUOTEDSTRING, TOKEN_KIND_BUILTIN_WORD, 0]) {
            [self attrValue_];
        }
    }
    
    [self fireDelegateSelector:@selector(parser:didMatchAttr:)];
}

- (void)attr_ {
    [self parseRule:@selector(__attr) withMemo:_attr_memo];
}

- (void)__attrName {
    
    [self matchWord:NO];
    
    [self fireDelegateSelector:@selector(parser:didMatchAttrName:)];
}

- (void)attrName_ {
    [self parseRule:@selector(__attrName) withMemo:_attrName_memo];
}

- (void)__attrValue {
    
    if ([self predicts:TOKEN_KIND_BUILTIN_WORD, 0]) {
        [self matchWord:NO];
    } else if ([self predicts:TOKEN_KIND_BUILTIN_QUOTEDSTRING, 0]) {
        [self matchQuotedString:NO];
    } else {
        [self raise:@"No viable alternative found in rule 'attrValue'."];
    }
    
    [self fireDelegateSelector:@selector(parser:didMatchAttrValue:)];
}

- (void)attrValue_ {
    [self parseRule:@selector(__attrValue) withMemo:_attrValue_memo];
}

- (void)__eq {
    
    [self match:HTMLPARSER_TOKEN_KIND_EQ discard:NO];
    
    [self fireDelegateSelector:@selector(parser:didMatchEq:)];
}

- (void)eq_ {
    [self parseRule:@selector(__eq) withMemo:_eq_memo];
}

- (void)__lt {
    
    [self match:HTMLPARSER_TOKEN_KIND_LT discard:NO];
    
    [self fireDelegateSelector:@selector(parser:didMatchLt:)];
}

- (void)lt_ {
    [self parseRule:@selector(__lt) withMemo:_lt_memo];
}

- (void)__gt {
    
    [self match:HTMLPARSER_TOKEN_KIND_GT discard:NO];
    
    [self fireDelegateSelector:@selector(parser:didMatchGt:)];
}

- (void)gt_ {
    [self parseRule:@selector(__gt) withMemo:_gt_memo];
}

- (void)__fwdSlash {
    
    [self match:HTMLPARSER_TOKEN_KIND_FWDSLASH discard:NO];
    
    [self fireDelegateSelector:@selector(parser:didMatchFwdSlash:)];
}

- (void)fwdSlash_ {
    [self parseRule:@selector(__fwdSlash) withMemo:_fwdSlash_memo];
}

- (void)__comment {
    
    [self matchComment:NO]; 
    
    [self fireDelegateSelector:@selector(parser:didMatchComment:)];
}

- (void)comment_ {
    [self parseRule:@selector(__comment) withMemo:_comment_memo];
}

@end