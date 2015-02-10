class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def ticket_added_email(email, ref, host, client_name)
    @email = email
    @ref = ref
    @url = "http://" + host
    @client_name = client_name
    # comment mailer for heroku
    #mail(to: @email, subject: 'Ticket added ' + @ref)
  end

  def ticket_replied_email(email, ref, host, reply, state, client_name)
    @email = email
    @ref = ref
    @url = "http://" + host
    @state = state
    @reply = reply
    # comment mailer for heroku
    # mail(to: @email, subject: 'Ticket replied ' + @ref)
  end
end