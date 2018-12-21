Customer.create(first_name: "Alice", last_name: "Amber")
Customer.create(first_name: "Bob", last_name: "Brown")
Customer.create(first_name: "Celest", last_name: "Charlston")

alice = Customer.find(1)
alice.accounts.create(number: 1001, balance: 1000.0)
alice.accounts.create(number: 1002, balance: 5000.0)
alice.accounts.create(number: 1003, balance: 0.0)

bob = Customer.find(2)
bob.accounts.create(number: 2001, balance: 2000.0)
bob.accounts.create(number: 2002, balance: 3000.0)

celest = Customer.find(2)
celest.accounts.create(number: 1234, balance: 1000.0)
celest.accounts.create(number: 1235, balance: 5000.0)
celest.accounts.create(number: 1236, balance: 0.0)
