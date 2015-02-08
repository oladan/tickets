class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show]

  respond_to :html

  def index
    @tickets = Ticket.all.paginate(:page => params[:page], :per_page => 5)
    respond_with(@tickets)
  end

  def new
    @uniq_ref = uniq_reference
    @ticket = Ticket.new
    respond_with(@ticket)
  end

  def create
    @ticket = Ticket.new(ticket_params)
    respond_to do |format|
      if @ticket.save
        format.html { redirect_to(tickets_path, :notice => 'Ticket was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def show
    respond_with(@ticket)
  end

  private
    def set_ticket
      # @ticket = Ticket.find(params[:id])
      @ticket = Ticket.find_by uniq_reference: params[:id]
    end

    def ticket_params
      params.require(:ticket).permit(:client_name, :client_email, :subject, :body, :department_id, 
                                     :uniq_reference, :state_id)
    end

    def char_gen
      ('A'..'Z').to_a.shuffle[0, 3].join
    end

    def hex_gen
      SecureRandom.hex(1).upcase
    end

    def uniq_reference
      char_gen + '-' + hex_gen + '-' + char_gen + '-' + hex_gen + '-' + char_gen
    end
end
