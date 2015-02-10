class RepliesController < ApplicationController
  before_action :authenticate_owner!
  
  def create
    @ticket = Ticket.find_by uniq_reference: params[:ticket_id]
    @reply = @ticket.replies.create(reply_params)
    if @reply.save
      flash[:notice] = "Reply created!"
      @ticket.update_attribute :state_id, reply_params[:state_id]
      @ticket.update_attribute :owner_id, reply_params[:owner_id]
      UserMailer.ticket_replied_email(@ticket.client_email, @ticket.uniq_reference, 
                                      request.host_with_port + ticket_path(@ticket),
                                      @reply.body, @ticket.state.name, @ticket.client_name).deliver
      redirect_to ticket_path(@ticket)
    else
      flash[:alert] = "Please write reply"
      redirect_to ticket_path(@ticket)
    end
  end

  private
    def reply_params
      params.require(:reply).permit(:body, :replyer, :current_owner_email, :owner_id, :state_id)
    end
end
