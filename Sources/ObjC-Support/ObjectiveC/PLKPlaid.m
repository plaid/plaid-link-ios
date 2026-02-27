#import "PLKPlaid.h"
#import "PLKPlaid+PrivateInitializers.h"

#pragma mark - Internal

@implementation PLKAccount

- (instancetype)initWithAccountID:(NSString *)ID
                             name:(NSString *)name
                             mask:(NSString *)mask
                          subtype:(id<PLKAccountSubtype>)subtype
               verificationStatus:(PLKVerificationStatus *)verificationStatus {
    if (self = [super init]) {
        _ID = [ID copy];
        _name = [name copy];
        _mask = [mask copy];
        _subtype = subtype;
        _verificationStatus = verificationStatus;
    }
    return self;
}

@end

@interface PLKVerificationStatus ()

@property(nonatomic, readwrite, nullable, copy) NSString *unknownStringValue;
@property(nonatomic, readwrite) PLKVerificationStatusValue value;

@end

@implementation PLKVerificationStatus

+ (instancetype)createWithValue:(PLKVerificationStatusValue)value {
    PLKVerificationStatus *status = [[self alloc] init];

    status.value = value;

    return status;
}

+ (instancetype)createWithUnknownStringValue:(NSString *)unknownStringValue {
    PLKVerificationStatus *status = [[self alloc] init];

    status.value = PLKVerificationStatusValueNone;
    status.unknownStringValue = unknownStringValue;

    return status;
}

@end

@interface PLKEventName ()

@property(nonatomic, readwrite, nullable, copy) NSString *unknownStringValue;
@property(nonatomic, readwrite) PLKEventNameValue value;

@end

@implementation PLKEventName

+ (instancetype)createWithValue:(PLKEventNameValue)value {
    PLKEventName *status = [[self alloc] init];

    status.value = value;

    return status;
}

+ (instancetype)createWithUnknownStringValue:(NSString *)unknownStringValue {
    PLKEventName *status = [[self alloc] init];

    status.value = PLKEventNameValueNone;
    status.unknownStringValue = unknownStringValue;

    return status;
}

@end

@interface PLKViewName ()

@property(nonatomic, readwrite, nullable, copy) NSString *unknownStringValue;
@property(nonatomic, readwrite) PLKViewNameValue value;

@end

@implementation PLKViewName

+ (instancetype)createWithValue:(PLKViewNameValue)value {
    PLKViewName *status = [[self alloc] init];

    status.value = value;

    return status;
}

+ (instancetype)createWithUnknownStringValue:(NSString *)unknownStringValue {
    PLKViewName *status = [[self alloc] init];

    status.value = PLKViewNameValueNone;
    status.unknownStringValue = unknownStringValue;

    return status;
}

@end

@interface PLKExitStatus ()

@property(nonatomic, readwrite, nullable, copy) NSString *unknownStringValue;
@property(nonatomic, readwrite) PLKExitStatusValue value;

@end

@implementation PLKExitStatus

+ (instancetype)createWithValue:(PLKExitStatusValue)value {
    PLKExitStatus *status = [[self alloc] init];

    status.value = value;

    return status;
}

+ (instancetype)createWithUnknownStringValue:(NSString *)unknownStringValue {
    PLKExitStatus *status = [[self alloc] init];

    status.value = PLKExitStatusValueNone;
    status.unknownStringValue = unknownStringValue;

    return status;
}

@end

@interface PLKAccountSubtypeUnknown ()

@property(nonatomic, readwrite, copy) NSString *rawStringValue;
@property(nonatomic, readwrite, copy) NSString *rawSubtypeStringValue;

@end

@implementation PLKAccountSubtypeUnknown

+ (instancetype)createWithRawTypeStringValue:(NSString *)rawTypeStringValue
                          rawSubtypeStringValue:(NSString *)rawSubtypeStringValue {
    PLKAccountSubtypeUnknown *unknownSubtype = [[self alloc] init];
    unknownSubtype.rawStringValue = rawTypeStringValue;
    unknownSubtype.rawSubtypeStringValue = rawSubtypeStringValue;
    return unknownSubtype;
}

@end

@interface PLKAccountSubtypeOther ()

@property(nonatomic, readwrite, copy) NSString *rawStringValue;

@end

@implementation PLKAccountSubtypeOther

+ (instancetype)createWithValue:(PLKAccountSubtypeValueOther)value {
    PLKAccountSubtypeOther *subtype = [[self alloc] init];

    switch (value) {
        case PLKAccountSubtypeValueOtherAll:
            subtype.rawStringValue = @"all";
            break;
        case PLKAccountSubtypeValueOtherNone:
            subtype.rawStringValue = nil;
            break;
        case PLKAccountSubtypeValueOtherOther:
            subtype.rawStringValue = @"other";
            break;
    }

    return subtype;
}

+ (instancetype)createWithRawStringValue:(NSString *)rawStringValue {
    PLKAccountSubtypeOther *otherSubtype = [[self alloc] init];
    otherSubtype.rawStringValue = rawStringValue;
    return otherSubtype;
}

@end

@interface PLKAccountSubtypeCredit ()

@property(nonatomic, readwrite, copy) NSString *rawStringValue;

@end

@implementation PLKAccountSubtypeCredit

+ (instancetype)createWithValue:(PLKAccountSubtypeValueCredit)value {
    PLKAccountSubtypeCredit *subtype = [[self alloc] init];

    switch (value) {
        case PLKAccountSubtypeValueCreditAll:
            subtype.rawStringValue = @"all";
            break;
        case PLKAccountSubtypeValueCreditNone:
            subtype.rawStringValue = nil;
            break;
        case PLKAccountSubtypeValueCreditCreditCard:
            subtype.rawStringValue = @"credit card";
            break;
        case PLKAccountSubtypeValueCreditPaypal:
            subtype.rawStringValue = @"paypal";
            break;
    }

    return subtype;
}

+ (instancetype)createWithUnknownValue:(NSString *)unknownValue {
    PLKAccountSubtypeCredit *subtype = [[self alloc] init];
    subtype.rawStringValue = unknownValue;
    return subtype;
}

@end

@interface PLKAccountSubtypeLoan ()

@property(nonatomic, readwrite, copy) NSString *rawStringValue;

@end

@implementation PLKAccountSubtypeLoan

+ (instancetype)createWithValue:(PLKAccountSubtypeValueLoan)value {
    PLKAccountSubtypeLoan *subtype = [[self alloc] init];

    switch (value) {
        case PLKAccountSubtypeValueLoanAll:
            subtype.rawStringValue = @"all";
            break;
        case PLKAccountSubtypeValueLoanNone:
            subtype.rawStringValue = nil;
            break;
        case PLKAccountSubtypeValueLoanAuto:
            subtype.rawStringValue = @"auto";
            break;
        case PLKAccountSubtypeValueLoanBusiness:
            subtype.rawStringValue = @"business";
            break;
        case PLKAccountSubtypeValueLoanCommercial:
            subtype.rawStringValue = @"commercial";
            break;
        case PLKAccountSubtypeValueLoanConstruction:
            subtype.rawStringValue = @"construction";
            break;
        case PLKAccountSubtypeValueLoanConsumer:
            subtype.rawStringValue = @"consumer";
            break;
        case PLKAccountSubtypeValueLoanHomeEquity:
            subtype.rawStringValue = @"home equity";
            break;
        case PLKAccountSubtypeValueLoanLineOfCredit:
            subtype.rawStringValue = @"line of credit";
            break;
        case PLKAccountSubtypeValueLoanLoan:
            subtype.rawStringValue = @"loan";
            break;
        case PLKAccountSubtypeValueLoanMortgage:
            subtype.rawStringValue = @"mortgage";
            break;
        case PLKAccountSubtypeValueLoanOverdraft:
            subtype.rawStringValue = @"overdraft";
            break;
        case PLKAccountSubtypeValueLoanStudent:
            subtype.rawStringValue = @"student";
            break;
    }

    return subtype;
}

+ (instancetype)createWithUnknownValue:(NSString *)unknownValue {
    PLKAccountSubtypeLoan *subtype = [[self alloc] init];
    subtype.rawStringValue = unknownValue;
    return subtype;
}

@end

@interface PLKAccountSubtypeDepository ()

@property(nonatomic, readwrite, copy) NSString *rawStringValue;

@end

@implementation PLKAccountSubtypeDepository

+ (instancetype)createWithValue:(PLKAccountSubtypeValueDepository)value {
    PLKAccountSubtypeDepository *subtype = [[self alloc] init];

    switch (value) {
        case PLKAccountSubtypeValueDepositoryAll:
            subtype.rawStringValue = @"all";
            break;
        case PLKAccountSubtypeValueDepositoryNone:
            subtype.rawStringValue = nil;
            break;
        case PLKAccountSubtypeValueDepositoryCashManagement:
            subtype.rawStringValue = @"cash management";
            break;
        case PLKAccountSubtypeValueDepositoryCd:
            subtype.rawStringValue = @"cd";
            break;
        case PLKAccountSubtypeValueDepositoryChecking:
            subtype.rawStringValue = @"checking";
            break;
        case PLKAccountSubtypeValueDepositoryEbt:
            subtype.rawStringValue = @"ebt";
            break;
        case PLKAccountSubtypeValueDepositoryHsa:
            subtype.rawStringValue = @"hsa";
            break;
        case PLKAccountSubtypeValueDepositoryMoneyMarket:
            subtype.rawStringValue = @"money market";
            break;
        case PLKAccountSubtypeValueDepositoryPaypal:
            subtype.rawStringValue = @"paypal";
            break;
        case PLKAccountSubtypeValueDepositoryPrepaid:
            subtype.rawStringValue = @"prepaid";
            break;
        case PLKAccountSubtypeValueDepositorySavings:
            subtype.rawStringValue = @"savings";
            break;
    }

    return subtype;
}

+ (instancetype)createWithUnknownValue:(NSString *)unknownValue {
    PLKAccountSubtypeDepository *subtype = [[self alloc] init];
    subtype.rawStringValue = unknownValue;
    return subtype;
}

@end

@interface PLKAccountSubtypeInvestment ()

@property(nonatomic, readwrite, copy) NSString *rawStringValue;

@end

@implementation PLKAccountSubtypeInvestment

+ (instancetype)createWithValue:(PLKAccountSubtypeValueInvestment)value {
    PLKAccountSubtypeInvestment *subtype = [[self alloc] init];

    switch (value) {
        case PLKAccountSubtypeValueInvestmentAll:
            subtype.rawStringValue = @"all";
            break;
        case PLKAccountSubtypeValueInvestmentNone:
            subtype.rawStringValue = nil;
            break;
        case PLKAccountSubtypeValueInvestment401a:
            subtype.rawStringValue = @"401a";
            break;
        case PLKAccountSubtypeValueInvestment401k:
            subtype.rawStringValue = @"401k";
            break;
        case PLKAccountSubtypeValueInvestment403B:
            subtype.rawStringValue = @"403B";
            break;
        case PLKAccountSubtypeValueInvestment457b:
            subtype.rawStringValue = @"457b";
            break;
        case PLKAccountSubtypeValueInvestment529:
            subtype.rawStringValue = @"529";
            break;
        case PLKAccountSubtypeValueInvestmentBrokerage:
            subtype.rawStringValue = @"brokerage";
            break;
        case PLKAccountSubtypeValueInvestmentCashIsa:
            subtype.rawStringValue = @"cash isa";
            break;
        case PLKAccountSubtypeValueInvestmentEducationSavingsAccount:
            subtype.rawStringValue = @"education savings account";
            break;
        case PLKAccountSubtypeValueInvestmentFixedAnnuity:
            subtype.rawStringValue = @"fixed annuity";
            break;
        case PLKAccountSubtypeValueInvestmentGic:
            subtype.rawStringValue = @"gic";
            break;
        case PLKAccountSubtypeValueInvestmentHealthReimbursementArrangement:
            subtype.rawStringValue = @"health reimbursement arrangement";
            break;
        case PLKAccountSubtypeValueInvestmentHsa:
            subtype.rawStringValue = @"hsa";
            break;
        case PLKAccountSubtypeValueInvestmentIra:
            subtype.rawStringValue = @"ira";
            break;
        case PLKAccountSubtypeValueInvestmentIsa:
            subtype.rawStringValue = @"isa";
            break;
        case PLKAccountSubtypeValueInvestmentKeogh:
            subtype.rawStringValue = @"keogh";
            break;
        case PLKAccountSubtypeValueInvestmentLif:
            subtype.rawStringValue = @"lif";
            break;
        case PLKAccountSubtypeValueInvestmentLira:
            subtype.rawStringValue = @"lira";
            break;
        case PLKAccountSubtypeValueInvestmentLrif:
            subtype.rawStringValue = @"lrif";
            break;
        case PLKAccountSubtypeValueInvestmentLrsp:
            subtype.rawStringValue = @"lrsp";
            break;
        case PLKAccountSubtypeValueInvestmentMutualFund:
            subtype.rawStringValue = @"mutual fund";
            break;
        case PLKAccountSubtypeValueInvestmentNonTaxableBrokerageAccount:
            subtype.rawStringValue = @"non-taxable brokerage account";
            break;
        case PLKAccountSubtypeValueInvestmentPension:
            subtype.rawStringValue = @"pension";
            break;
        case PLKAccountSubtypeValueInvestmentPlan:
            subtype.rawStringValue = @"plan";
            break;
        case PLKAccountSubtypeValueInvestmentPrif:
            subtype.rawStringValue = @"prif";
            break;
        case PLKAccountSubtypeValueInvestmentProfitSharingPlan:
            subtype.rawStringValue = @"profit sharing plan";
            break;
        case PLKAccountSubtypeValueInvestmentRdsp:
            subtype.rawStringValue = @"rdsp";
            break;
        case PLKAccountSubtypeValueInvestmentResp:
            subtype.rawStringValue = @"resp";
            break;
        case PLKAccountSubtypeValueInvestmentRetirement:
            subtype.rawStringValue = @"retirement";
            break;
        case PLKAccountSubtypeValueInvestmentRlif:
            subtype.rawStringValue = @"rlif";
            break;
        case PLKAccountSubtypeValueInvestmentRoth401k:
             subtype.rawStringValue = @"roth 401k";
            break;
        case PLKAccountSubtypeValueInvestmentRoth:
            subtype.rawStringValue = @"roth";
            break;
        case PLKAccountSubtypeValueInvestmentRrif:
            subtype.rawStringValue = @"rrif";
            break;
        case PLKAccountSubtypeValueInvestmentRrsp:
            subtype.rawStringValue = @"rrsp";
            break;
        case PLKAccountSubtypeValueInvestmentSarsep:
            subtype.rawStringValue = @"sarsep";
            break;
        case PLKAccountSubtypeValueInvestmentSepIra:
            subtype.rawStringValue = @"sep ira";
            break;
        case PLKAccountSubtypeValueInvestmentSimpleIra:
            subtype.rawStringValue = @"simple ira";
            break;
        case PLKAccountSubtypeValueInvestmentSipp:
            subtype.rawStringValue = @"sipp";
            break;
        case PLKAccountSubtypeValueInvestmentStockPlan:
            subtype.rawStringValue = @"stock plan";
            break;
        case PLKAccountSubtypeValueInvestmentTfsa:
            subtype.rawStringValue = @"tfsa";
            break;
        case PLKAccountSubtypeValueInvestmentThriftSavingsPlan:
            subtype.rawStringValue = @"thrift savings plan";
            break;
        case PLKAccountSubtypeValueInvestmentTrust:
            subtype.rawStringValue = @"trust";
            break;
        case PLKAccountSubtypeValueInvestmentUgma:
            subtype.rawStringValue = @"ugma";
            break;
        case PLKAccountSubtypeValueInvestmentUtma:
            subtype.rawStringValue = @"utma";
            break;
        case PLKAccountSubtypeValueInvestmentVariableAnnuity:
            subtype.rawStringValue = @"variable annuity";
            break;
    }

    return subtype;
}

+ (instancetype)createWithUnknownValue:(NSString *)unknownValue {
    PLKAccountSubtypeInvestment *subtype = [[self alloc] init];
    subtype.rawStringValue = unknownValue;
    return subtype;
}

@end

@implementation PLKInstitution

- (instancetype)initWithID:(NSString *)ID name:(NSString *)name {
    if (self = [super init]) {
        _name = [name copy];
        _ID = [ID copy];
    }
    return self;
}

@end

@implementation PLKEventMetadata

- (instancetype)initWithError:(PLKExitError *)error
                   exitStatus:(PLKExitStatus *)exitStatus
                institutionID:(NSString *)institutionID
              institutionName:(NSString *)institutionName
       institutionSearchQuery:(NSString *)institutionSearchQuery
            accountNumberMask:(NSString *)accountNumberMask
                 isUpdateMode:(NSString *)isUpdateMode
                  matchReason:(NSString *)matchReason
                      issueID:(NSString *)issueID
             issueDescription:(NSString *)issueDescription
              issueDetectedAt:(NSDate *)issueDetectedAt
                routingNumber:(NSString *)routingNumber
                    selection:(NSString *)selection
                linkSessionID:(NSString *)linkSessionID
                      mfaType:(PLKMFAType)mfaType
                    requestID:(NSString *)requestID
                    timestamp:(NSDate *)timestamp
                     viewName:(PLKViewName *)viewName
                 metadataJSON:(PLKRawJSONMetadata *)metadataJSON {
    if (self = [super init]) {
        _error = error;
        _exitStatus = exitStatus;
        _institutionID = [institutionID copy];
        _institutionName = [institutionName copy];
        _institutionSearchQuery = [institutionSearchQuery copy];
        _accountNumberMask = [accountNumberMask copy];
        _isUpdateMode = [isUpdateMode copy];
        _matchReason = [matchReason copy];
        _issueID = [issueID copy];
        _issueDescription = [issueDescription copy];
        _issueDetectedAt = [issueDetectedAt copy];
        _routingNumber = [routingNumber copy];
        _selection = [selection copy];
        _linkSessionID = [linkSessionID copy];
        _mfaType = mfaType;
        _requestID = requestID;
        _timestamp = timestamp;
        _viewName = viewName;
        _metadataJSON = metadataJSON;
    }
    return self;
}

@end

@implementation PLKLinkEvent

- (instancetype)initWithEventName:(PLKEventName *)eventName
                    eventMetadata:(PLKEventMetadata *)eventMetadata {
    if (self = [super init]) {
        _eventName = eventName;
        _eventMetadata = eventMetadata;
    }
    return self;
}

@end

@implementation PLKExitMetadata

- (instancetype)initWithStatus:(PLKExitStatus *)status
                   institution:(PLKInstitution *)institution
                     requestID:(NSString *)requestID
                 linkSessionID:(NSString *)linkSessionID
                  metadataJSON:(PLKRawJSONMetadata *)metadataJSON {
    if (self = [super init]) {
        _status = status;
        _institution = institution;
        _requestID = [requestID copy];
        _linkSessionID = [linkSessionID copy];
        _metadataJSON = [metadataJSON copy];
    }
    return self;
}

@end

@implementation PLKLinkExit

- (instancetype)initWithError:(NSError *)error
                     metadata:(PLKExitMetadata *)metadata {
    if (self = [super init]) {
        _error = error;
        _metadata = metadata;
    }
    return self;
}

@end

@implementation PLKSuccessMetadata

- (instancetype)initWithLinkSessionID:(NSString *)linkSessionID
                          institution:(PLKInstitution *)institution
                             accounts:(NSArray<PLKAccount *> *)accounts
                          metadataJSON:(PLKRawJSONMetadata *)metadataJSON {
    if (self = [super init]) {
        _linkSessionID = [linkSessionID copy];
        _institution = institution;
        _accounts = [accounts copy];
        _metadataJSON = [metadataJSON copy];
    }
    return self;
}

@end

@implementation PLKLinkSuccess

- (instancetype)initWithPublicToken:(NSString *)publicToken
                           metadata:(PLKSuccessMetadata *)metadata {
    if (self = [super init]) {
        _publicToken = [publicToken copy];
        _metadata = metadata;
    }
    return self;
}

@end

#pragma mark - Public

@implementation PLKLinkTokenConfiguration

- (instancetype)initWithToken:(NSString *)token
                    onSuccess:(PLKOnSuccessHandler)successHandler {
    NSParameterAssert(token);
    NSParameterAssert(successHandler);

    if (self = [super init]) {
        _token = [token copy];
        _onSuccess = successHandler;

        // Initializing handlers
        _onExit = ^(PLKLinkExit *exit){ };
        _onEvent = ^(PLKLinkEvent *event){ };

        // Since onLoad is nullable, we can start as nil,
        // or provide an empty block if the SDK expects to call it blindly.
        _onLoad = nil;
    }
    return self;
}

+ (instancetype)createWithToken:(NSString *)token
                      onSuccess:(PLKOnSuccessHandler)successHandler {
    return [[self alloc] initWithToken:token
                             onSuccess:successHandler];
}

@end

@implementation PLKLayerTokenConfiguration

- (instancetype)initWithToken:(NSString *)token
                    onSuccess:(PLKOnSuccessHandler)successHandler {
    NSParameterAssert(token);
    NSParameterAssert(successHandler);

    if (self = [super init]) {
        _token = [token copy];
        _onSuccess = successHandler;
        // Default empty blocks to prevent crashes if called before being set
        _onExit = ^(PLKLinkExit *exit){ };
        _onEvent = ^(PLKLinkEvent *event){ };
    }
    return self;
}

+ (instancetype)createWithToken:(NSString *)token
                      onSuccess:(PLKOnSuccessHandler)successHandler {
    return [[self alloc] initWithToken:token
                             onSuccess:successHandler];
}

@end

@implementation PLKEmbeddedLinkTokenConfiguration

- (instancetype)initWithToken:(NSString *)token
                    onSuccess:(PLKOnSuccessHandler)successHandler {
    NSParameterAssert(token);
    NSParameterAssert(successHandler);

    if (self = [super init]) {
        _token = [token copy];
        _onSuccess = successHandler;
        // Default empty blocks to prevent crashes if called before being set
        _onExit = ^(PLKLinkExit *exit){ };
        _onEvent = ^(PLKLinkEvent *event){ };
    }
    return self;
}

+ (instancetype)createWithToken:(NSString *)token
                      onSuccess:(PLKOnSuccessHandler)successHandler {
    return [[self alloc] initWithToken:token
                             onSuccess:successHandler];
}

@end

@implementation PLKSubmissionData

- (instancetype)initWithPhoneNumber:(NSString * _Nullable)phoneNumber {
    self = [super init];
    if (self) {
        _phoneNumber = [phoneNumber copy];
    }
    return self;
}

@end
