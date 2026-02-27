import Foundation
import LinkKit
import LinkKitObjCInternal

extension AccountSubtype.Credit {
    var toObjC: PLKAccountSubtypeValueCredit? {
        switch self {
        case .all:
            return .all
        case .creditCard:
            return .creditCard
        case .paypal:
            return .paypal
        case .unknown:
            return nil
        @unknown default:
            return nil
        }
    }
}

extension AccountSubtype.Loan {
    var toObjC: PLKAccountSubtypeValueLoan? {
        switch self {
        case .all:
            return .all
        case .unknown:
            return nil
        case .auto:
            return .auto
        case .business:
            return .business
        case .commercial:
            return .commercial
        case .construction:
            return .construction
        case .consumer:
            return .consumer
        case .homeEquity:
            return .homeEquity
        case .lineOfCredit:
            return .lineOfCredit
        case .loan:
            return .loan
        case .mortgage:
            return .mortgage
        case .overdraft:
            return .overdraft
        case .student:
            return .student
        @unknown default:
            return nil
        }
    }
}

extension AccountSubtype.Depository {
    var toObjC: PLKAccountSubtypeValueDepository? {
        switch self {
        case .all:
            return .all
        case .unknown:
            return nil
        case .cashManagement:
            return .cashManagement
        case .cd:
            return .cd
        case .checking:
            return .checking
        case .ebt:
            return .ebt
        case .hsa:
            return .hsa
        case .moneyMarket:
            return .moneyMarket
        case .paypal:
            return .paypal
        case .prepaid:
            return .prepaid
        case .savings:
            return .savings
        @unknown default:
            return nil
        }
    }
}

extension AccountSubtype.Investment {
    var toObjC: PLKAccountSubtypeValueInvestment? {
        switch self {
        case .all:
            return .investmentAll
        case .unknown:
            return nil
        case .investment401a:
            return .investment401a
        case .investment401k:
            return .investment401k
        case .investment403B:
            return .investment403B
        case .investment457b:
            return .investment457b
        case .investment529:
            return .investment529
        case .brokerage:
            return .investmentBrokerage
        case .cashIsa:
            return .investmentCashIsa
        case .educationSavingsAccount:
            return .investmentEducationSavingsAccount
        case .fixedAnnuity:
            return .investmentFixedAnnuity
        case .gic:
            return .investmentGic
        case .healthReimbursementArrangement:
            return .investmentHealthReimbursementArrangement
        case .hsa:
            return .investmentHsa
        case .ira:
            return .investmentIra
        case .isa:
            return .investmentIsa
        case .keogh:
            return .investmentKeogh
        case .lif:
            return .investmentLif
        case .lira:
            return .investmentLira
        case .lrif:
            return .investmentLrif
        case .lrsp:
            return .investmentLrsp
        case .mutualFund:
            return .investmentMutualFund
        case .nonTaxableBrokerageAccount:
            return .investmentNonTaxableBrokerageAccount
        case .pension:
            return .investmentPension
        case .plan:
            return .investmentPlan
        case .prif:
            return .investmentPrif
        case .profitSharingPlan:
            return .investmentProfitSharingPlan
        case .rdsp:
            return .investmentRdsp
        case .resp:
            return .investmentResp
        case .retirement:
            return .investmentRetirement
        case .rlif:
            return .investmentRlif
        case .roth401k:
            return .investmentRoth401k
        case .roth:
            return .investmentRoth
        case .rrif:
            return .investmentRrif
        case .rrsp:
            return .investmentRrsp
        case .sarsep:
            return .investmentSarsep
        case .sepIra:
            return .investmentSepIra
        case .simpleIra:
            return .investmentSimpleIra
        case .sipp:
            return .investmentSipp
        case .stockPlan:
            return .investmentStockPlan
        case .tfsa:
            return .investmentTfsa
        case .thriftSavingsPlan:
            return .investmentThriftSavingsPlan
        case .trust:
            return .investmentTrust
        case .ugma:
            return .investmentUgma
        case .utma:
            return .investmentUtma
        case .variableAnnuity:
            return .investmentVariableAnnuity
        @unknown default:
            return nil
        }
    }
}

extension AccountSubtype {
    var toObjC: PLKAccountSubtype {
        switch self {
        case .unknown(let type, let subtype):
            return PLKAccountSubtypeUnknown.create(withRawTypeStringValue: type, rawSubtypeStringValue: subtype)

        case .other(let other):
            switch other {
            case .all:
                return PLKAccountSubtypeOther.create(withValue: .all)
            case .other:
                return PLKAccountSubtypeOther.create(withValue: .other)
            case .unknown(let rawValue):
                return PLKAccountSubtypeOther.create(withRawStringValue: rawValue)
            @unknown default:
                return PLKAccountSubtypeOther.create(withRawStringValue: "unknown default")
            }

        case .credit(let credit):
            if let creditValue = credit.toObjC {
                return PLKAccountSubtypeCredit.create(withValue: creditValue)
            } else {
                return PLKAccountSubtypeCredit.create(withUnknownValue: credit.description)
            }

        case .loan(let loan):
            if let loanValue = loan.toObjC {
                return PLKAccountSubtypeLoan.create(withValue: loanValue)
            } else {
                return PLKAccountSubtypeLoan.create(withUnknownValue: loan.description)
            }

        case .depository(let depository):
            if let depositoryValue = depository.toObjC {
                return PLKAccountSubtypeDepository.create(withValue: depositoryValue)
            } else {
                return PLKAccountSubtypeDepository.create(withUnknownValue: depository.description)
            }

        case .investment(let investment):
            if let investmentValue = investment.toObjC {
                return PLKAccountSubtypeInvestment.create(withValue: investmentValue)
            } else {
                return PLKAccountSubtypeInvestment.create(withUnknownValue: investment.description)
            }
        @unknown default:
            return PLKAccountSubtypeUnknown.create(
                withRawTypeStringValue: "unknownDefault",
                rawSubtypeStringValue: "unknownDefault"
            )
        }
    }
}
