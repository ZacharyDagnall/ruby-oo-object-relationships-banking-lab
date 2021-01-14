class Transfer
  attr_accessor :sender, :receiver, :status, :amount

  def initialize(sender,receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = 'pending'
    @amount = amount
    @previous_state = {sender: @sender, receiver: @receiver, sender_amount: @sender.balance,receiver_amount: @receiver.balance}
    @executed = false
  end

  def valid?
    self.sender.valid? && self.receiver.valid? && self.sender.balance>self.amount
  end

  def execute_transaction
    if self.valid? && @status!='complete'
      @executed = true
      self.sender.balance-=self.amount
      self.receiver.balance+=self.amount
      self.status = 'complete'
    else 
      @executed = false
      self.status = 'rejected'
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @executed
      self.sender.balance+=self.amount
      self.receiver.balance-=self.amount
      @executed = false
      self.status='reversed'
    end
  end


end
