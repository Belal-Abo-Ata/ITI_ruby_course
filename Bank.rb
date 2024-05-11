require_relative 'Logger'

class Bank
  def self.make_transactions(users, transactions, &callback)
    raise NotImplementedError, "this is an abstract class and the method make_transaction can't be called"
  end
end

class CBABank < Bank
  def self.make_transactions(users, transactions, &callback)
    transaction_details = transactions.map do |transaction|
      "User #{transaction.user.name}, value #{transaction.value}"
    end.join(', ')
    Logger.info("Making Transactions: #{transaction_details}")

    transactions.each do |transaction|
      if transaction.user.balance + transaction.value < 0
        raise 'Not enough balance'
      elsif !users.include?(transaction.user)
        raise "User: #{transaction.user.name} is not exist"
      else
        transaction.user.balance += transaction.value
        Logger.warning("#{transaction.user.name}'s balance is 0") if transaction.user.balance == 0
        Logger.info("User #{transaction.user.name}, value #{transaction.value} has been done")
        callback.call('success', transaction)
      end
    rescue StandardError => e
      Logger.error("User #{transaction.user.name} transaction with value #{transaction.value} failed with message #{e.message}")
      callback.call('failure', transaction)
    end
  end
end
