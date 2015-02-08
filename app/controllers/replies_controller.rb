class RepliesController < ApplicationController
  before_action :authenticate_owner!
  
  def create
    @ticket = Ticket.find(params[:ticket_id])
    @reply = @ticket.replies.create(reply_params)
    @ticket.update_attribute :state_id, reply_params[:state_id]
    @ticket.update_attribute :owner_id, reply_params[:owner_id]
    redirect_to '/tickets/' + @ticket.uniq_reference
  end

  private
    def reply_params
      params.require(:reply).permit(:body, :replyer, :current_owner_email, :owner_id, :state_id)
    end
end
