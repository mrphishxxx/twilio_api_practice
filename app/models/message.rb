class Message < ActiveRecord::Base
  before_create :send_message

  private

  def send_message
    begin
      response = RestClient::Request.new(
        :method => :post,
        :url => 'https://api.twilio.com/2010-04-01/Accounts/AC33934a01b1e0ee001008569d4a8f2671/Messages.json',
        :user => ENV['TWILIO_ACCOUNT_SID'],
        :password => ENV['TWILIO_AUTH_TOKEN'],
        :payload => { :Body => body,
                      :To => to,
                      :From => from }
      ).execute
    rescue RestClient::BadRequest => error
      message = JSON.parse(error.response)['message']
      errors.add(:base, message)
      false
    end 
  end

end
