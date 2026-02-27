import LinkKit
import XCTest

@testable import LinkKitObjC
@testable import LinkKitObjCInternal

final class PLKAccountSubtypeTests: XCTestCase {

    func testCreditCardToObjC() {
        let subtype = AccountSubtype.Credit.creditCard
        let objcSubtype = subtype.toObjC
        XCTAssertEqual(objcSubtype, .creditCard)
    }

    func testCreditPaypalToObjC() {
        let subtype = AccountSubtype.Credit.paypal
        let objcSubtype = subtype.toObjC
        XCTAssertEqual(objcSubtype, .paypal)
    }

    func testCreditAllToObjC() {
        let subtype = AccountSubtype.Credit.all
        let objcSubtype = subtype.toObjC
        XCTAssertEqual(objcSubtype, .all)
    }

    func testCreditUnknownToObjC() {
        let subtype = AccountSubtype.Credit.unknown("custom_credit")
        let objcSubtype = subtype.toObjC
        XCTAssertNil(objcSubtype)
    }

    // MARK: - Loan Subtype Tests

    func testLoanMortgageToObjC() {
        let subtype = AccountSubtype.Loan.mortgage
        let objcSubtype = subtype.toObjC
        XCTAssertEqual(objcSubtype, .mortgage)
    }

    func testLoanAutoToObjC() {
        let subtype = AccountSubtype.Loan.auto
        let objcSubtype = subtype.toObjC
        XCTAssertEqual(objcSubtype, .auto)
    }

    func testLoanStudentToObjC() {
        let subtype = AccountSubtype.Loan.student
        let objcSubtype = subtype.toObjC
        XCTAssertEqual(objcSubtype, .student)
    }

    func testLoanHomeEquityToObjC() {
        let subtype = AccountSubtype.Loan.homeEquity
        let objcSubtype = subtype.toObjC
        XCTAssertEqual(objcSubtype, .homeEquity)
    }

    func testLoanLineOfCreditToObjC() {
        let subtype = AccountSubtype.Loan.lineOfCredit
        let objcSubtype = subtype.toObjC
        XCTAssertEqual(objcSubtype, .lineOfCredit)
    }

    func testLoanAllToObjC() {
        let subtype = AccountSubtype.Loan.all
        let objcSubtype = subtype.toObjC
        XCTAssertEqual(objcSubtype, .all)
    }

    func testLoanUnknownToObjC() {
        let subtype = AccountSubtype.Loan.unknown("custom_loan")
        let objcSubtype = subtype.toObjC
        XCTAssertNil(objcSubtype)
    }

    // MARK: - Depository Subtype Tests

    func testDepositoryCheckingToObjC() {
        let subtype = AccountSubtype.Depository.checking
        let objcSubtype = subtype.toObjC
        XCTAssertEqual(objcSubtype, .checking)
    }

    func testDepositorySavingsToObjC() {
        let subtype = AccountSubtype.Depository.savings
        let objcSubtype = subtype.toObjC
        XCTAssertEqual(objcSubtype, .savings)
    }

    func testDepositoryMoneyMarketToObjC() {
        let subtype = AccountSubtype.Depository.moneyMarket
        let objcSubtype = subtype.toObjC
        XCTAssertEqual(objcSubtype, .moneyMarket)
    }

    func testDepositoryCdToObjC() {
        let subtype = AccountSubtype.Depository.cd
        let objcSubtype = subtype.toObjC
        XCTAssertEqual(objcSubtype, .cd)
    }

    func testDepositoryCashManagementToObjC() {
        let subtype = AccountSubtype.Depository.cashManagement
        let objcSubtype = subtype.toObjC
        XCTAssertEqual(objcSubtype, .cashManagement)
    }

    func testDepositoryPaypalToObjC() {
        let subtype = AccountSubtype.Depository.paypal
        let objcSubtype = subtype.toObjC
        XCTAssertEqual(objcSubtype, .paypal)
    }

    func testDepositoryPrepaidToObjC() {
        let subtype = AccountSubtype.Depository.prepaid
        let objcSubtype = subtype.toObjC
        XCTAssertEqual(objcSubtype, .prepaid)
    }

    func testDepositoryAllToObjC() {
        let subtype = AccountSubtype.Depository.all
        let objcSubtype = subtype.toObjC
        XCTAssertEqual(objcSubtype, .all)
    }

    func testDepositoryUnknownToObjC() {
        let subtype = AccountSubtype.Depository.unknown("custom_depository")
        let objcSubtype = subtype.toObjC
        XCTAssertNil(objcSubtype)
    }

    // MARK: - Investment Subtype Tests

    func testInvestment401kToObjC() {
        let subtype = AccountSubtype.Investment.investment401k
        let objcSubtype = subtype.toObjC
        XCTAssertEqual(objcSubtype, .investment401k)
    }

    func testInvestment401aToObjC() {
        let subtype = AccountSubtype.Investment.investment401a
        let objcSubtype = subtype.toObjC
        XCTAssertEqual(objcSubtype, .investment401a)
    }

    func testInvestment403BToObjC() {
        let subtype = AccountSubtype.Investment.investment403B
        let objcSubtype = subtype.toObjC
        XCTAssertEqual(objcSubtype, .investment403B)
    }

    func testInvestment457bToObjC() {
        let subtype = AccountSubtype.Investment.investment457b
        let objcSubtype = subtype.toObjC
        XCTAssertEqual(objcSubtype, .investment457b)
    }

    func testInvestment529ToObjC() {
        let subtype = AccountSubtype.Investment.investment529
        let objcSubtype = subtype.toObjC
        XCTAssertEqual(objcSubtype, .investment529)
    }

    func testInvestmentBrokerageToObjC() {
        let subtype = AccountSubtype.Investment.brokerage
        let objcSubtype = subtype.toObjC
        XCTAssertEqual(objcSubtype, .investmentBrokerage)
    }

    func testInvestmentIraToObjC() {
        let subtype = AccountSubtype.Investment.ira
        let objcSubtype = subtype.toObjC
        XCTAssertEqual(objcSubtype, .investmentIra)
    }

    func testInvestmentRothToObjC() {
        let subtype = AccountSubtype.Investment.roth
        let objcSubtype = subtype.toObjC
        XCTAssertEqual(objcSubtype, .investmentRoth)
    }

    func testInvestmentRoth401kToObjC() {
        let subtype = AccountSubtype.Investment.roth401k
        let objcSubtype = subtype.toObjC
        XCTAssertEqual(objcSubtype, .investmentRoth401k)
    }

    func testInvestmentMutualFundToObjC() {
        let subtype = AccountSubtype.Investment.mutualFund
        let objcSubtype = subtype.toObjC
        XCTAssertEqual(objcSubtype, .investmentMutualFund)
    }

    func testInvestmentPensionToObjC() {
        let subtype = AccountSubtype.Investment.pension
        let objcSubtype = subtype.toObjC
        XCTAssertEqual(objcSubtype, .investmentPension)
    }

    func testInvestmentAllToObjC() {
        let subtype = AccountSubtype.Investment.all
        let objcSubtype = subtype.toObjC
        XCTAssertEqual(objcSubtype, .investmentAll)
    }

    func testInvestmentUnknownToObjC() {
        let subtype = AccountSubtype.Investment.unknown("custom_investment")
        let objcSubtype = subtype.toObjC
        XCTAssertNil(objcSubtype)
    }

    // MARK: - Other Subtype Tests

    func testOtherAllToObjC() {
        let subtype: AccountSubtype = .other(.all)
        let objcSubtype = subtype.toObjC
        XCTAssertEqual(objcSubtype.rawStringValue, "all")
    }

    func testOtherOtherToObjC() {
        let subtype: AccountSubtype = .other(.other)
        let objcSubtype = subtype.toObjC
        XCTAssertEqual(objcSubtype.rawStringValue, "other")
    }

    func testOtherUnknownToObjC() {
        let subtype: AccountSubtype = .other(.unknown("custom_other"))
        let objcSubtype = subtype.toObjC
        XCTAssertEqual(objcSubtype.rawStringValue, "custom_other")
    }

    // MARK: - AccountSubtype (Full Enum) Tests

    func testAccountSubtypeCreditToObjC() {
        let subtype: AccountSubtype = .credit(.creditCard)
        let objcSubtype = subtype.toObjC
        XCTAssertTrue(objcSubtype is PLKAccountSubtypeCredit)
        XCTAssertEqual(objcSubtype.rawStringValue, "credit card")
    }

    func testAccountSubtypeLoanToObjC() {
        let subtype: AccountSubtype = .loan(.mortgage)
        let objcSubtype = subtype.toObjC
        XCTAssertTrue(objcSubtype is PLKAccountSubtypeLoan)
        XCTAssertEqual(objcSubtype.rawStringValue, "mortgage")
    }

    func testAccountSubtypeDepositoryToObjC() {
        let subtype: AccountSubtype = .depository(.checking)
        let objcSubtype = subtype.toObjC
        XCTAssertTrue(objcSubtype is PLKAccountSubtypeDepository)
        XCTAssertEqual(objcSubtype.rawStringValue, "checking")
    }

    func testAccountSubtypeInvestmentToObjC() {
        let subtype: AccountSubtype = .investment(.investment401k)
        let objcSubtype = subtype.toObjC
        XCTAssertTrue(objcSubtype is PLKAccountSubtypeInvestment)
        XCTAssertEqual(objcSubtype.rawStringValue, "401k")
    }

    func testAccountSubtypeOtherToObjC() {
        let subtype: AccountSubtype = .other(.all)
        let objcSubtype = subtype.toObjC
        XCTAssertTrue(objcSubtype is PLKAccountSubtypeOther)
        XCTAssertEqual(objcSubtype.rawStringValue, "all")
    }

    func testAccountSubtypeUnknownToObjC() {
        let subtype: AccountSubtype = .unknown(type: "custom_type", subtype: "custom_subtype")
        let objcSubtype = subtype.toObjC
        XCTAssertTrue(objcSubtype is PLKAccountSubtypeUnknown)
        if let unknownSubtype = objcSubtype as? PLKAccountSubtypeUnknown {
            XCTAssertEqual(unknownSubtype.rawStringValue, "custom_type")
            XCTAssertEqual(unknownSubtype.rawSubtypeStringValue, "custom_subtype")
        }
    }
}
