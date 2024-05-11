require_relative 'User'
require_relative 'Transaction'
require_relative 'Bank'

users = [
  User.new('Ali', 200),
  User.new('Peter', 500),
  User.new('Manda', 100)
]

out_side_bank_users = [
  User.new('Menna', 400)
]

transactions = [
  Transaction.new(users[0], -20),
  Transaction.new(users[0], -30),
  Transaction.new(users[0], -50),
  Transaction.new(users[0], -100),
  Transaction.new(users[0], -100),
  Transaction.new(out_side_bank_users[0], -100)
]

callback = lambda do |status, transaction|
  case status
  when 'success'
    puts "Call endpoint for success of User #{transaction.user.name} transaction with value #{transaction.value}"
  when 'failure'
    reason = transaction.value < 0 ? 'Not enough balance' : 'not exist in the bank!!'
    puts "Call endpoint for failure of User #{transaction.user.name} transaction with value #{transaction.value} with reason #{transaction.user.name} #{reason}"
  end
end

CBABank.make_transactions(users, transactions, &callback)
