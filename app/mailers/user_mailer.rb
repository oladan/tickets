class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def ticket_added_email(ticket)
    @ticket = ticket
    @ref = @ticket[:uniq_reference]
    mail(to: @ticket[:client_email], subject: 'Ticket added ' + @ref)
  end

  def ticket_replied_email(state_name, uniq_reference, reply_text, email)
    @ref = uniq_reference
    @status = state_name
    @reply_text = reply_text
    mail(to: email, subject: 'Ticket replied ' + @ref)
  end
end
