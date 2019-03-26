enum BankOperation {
    case withdrawl(value: Double)
    case deposit(from: String, value:Double)
}

protocol BankAccountProtol {
    init(number: String, holder:String)
    
    var balance:Double{get}
    var statement: [BankOperation] {get}
    
    func withdrawl(value: Double) throws
    func deposit(value:Double, from account: String)
    func formattedStatement() -> String
}

enum BankAccountErro: Error {
    case isuficientFunds(currentBalance: Double)
}

class MyBank: BankAccountProtol {
    private let number:String
    private let holder: String
    private(set) var balance:Double
    private(set) var statement: [BankOperation]
    
    required init(number: String, holder: String) {
        self.number = number
        self.holder = holder
        self.balance = 0.0
        self.statement = []
        
    }
    
    func withdrawl(value: Double) throws {
        if self.balance >= value{
           self.balance = self.balance - value
           self.statement.append(.withdrawl(value:value))
        }
    }
    
    func deposit(value: Double, from account: String) {
     
            self.balance = self.balance + value
            self.statement.append(.deposit(from: account, value: value))
        
        
    }
    
   func formattedStatement() -> String{
        var stringResul = " OPER VALUE    FROM\n"
        for stat in self.statement{
            switch stat {
            case let .deposit(from ,value):
                 stringResul += "Dep " + String(value) + "    " + from + "\n"
            case let .withdrawl(value):
                 stringResul += "WTH    " + String(value) + "\n"
            }
        }
        return stringResul
    }
    
    
}



var teste=MyBank(
    number:"10",holder:"tes"
)

teste.deposit(value:10,from:"13")
try teste.withdrawl(value: 3)
print(teste.formattedStatement())
