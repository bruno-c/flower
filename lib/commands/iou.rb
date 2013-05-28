# encoding: utf-8
require_relative '../debt'

class IOU < Flower::Command
  respond_to "iou"

  class << self
    def description
      "Your bank™, in your chat!"
    end

    def respond message
      from = message.sender[:nick].downcase
      to = message.argument.split(" ").first.downcase
      amount = message.argument.split(" ")[1]
      debt = Debt.new from: from, to: to, amount: amount.to_i

      if to && amount
        debt.create!
        message.paste "Debt to #{to.capitalize} registered for #{amount}, total debt: #{debt.total}"
      elsif to
        message.paste "You owe #{debt.total} to #{to.capitalize}"
      end
    end
  end
end
