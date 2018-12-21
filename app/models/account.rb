class Account < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  validates :balance, numericality: { greater_than_or_equal_to: 0 },
                      presence: true
  validates :number, uniqueness: true, presence: true

  def withdraw(amount)
    if amount > 0
      if amount < self.balance
        self.balance = self.balance - amount
        self.save
        puts "Der Betrag von " + amount.to_s + " wurde abgehoben"
        puts "Ihr neuer Kontostand ist: " + self.balance.to_s
        self.transactions.create(amount: -amount, description: "Withdraw", balance_after_transaction: self.balance)
      else
        puts "Auf Ihrem Konto ist nicht genug Geld vorhanden"
      end
    else
      puts "Betrag muss positiv sein"
    end
  end

  def deposit(amount)
    if amount > 0
      self.balance = self.balance + amount
      self.save
      puts "Der Betrag von " + amount.to_s + " wurde eingezahlt"
      puts "Ihr neuer Kontostand ist: " + self.balance.to_s
      self.transactions.create(amount: amount, description: "Deposit", balance_after_transaction: self.balance)
    else
      puts "Betrag muss positiv sein"
    end
  end

  def transfer(number, amount)
    if amount > 0
      if amount < self.balance
        other_account = Account.where(number: number).first
        self.balance = self.balance - amount
        self.save
        other_account.balance = other_account.balance + amount
        other_account.save
        self.transactions.create(amount: -amount,
          description: "Transfer to " + number.to_s,
          balance_after_transaction: self.balance)
        other_account.transactions.create(amount: amount,
          description: "Transfer from " + self.number.to_s,
          balance_after_transaction: other_account.balance)
        puts "Transfer erfolgreich"
        puts "Ihr neuer Kontostand ist: " + self.balance.to_s
      else
        puts "Nicht genügend Geld auf dem Konto"
      end
    else
      puts "Betrag muss positiv sein"
    end
  end

  def statement
    puts "Kundenname: " + self.customer.first_name + " " + self.customer.last_name
    puts "Kontonummer: " + self.number.to_s
    puts "Kontostand: " + self.balance.to_s
    puts "Transactions: "
    self.transactions.all.each do |transaction|
      puts "------"
      puts "Beschreibung: " + transaction.description
      puts "Betrag: " + transaction.amount.to_s
      puts "Kontostand danach " + transaction.balance_after_transaction.to_s
    end
  end
end
