class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show]

  respond_to :html

  def index
    @departments = Department.all
    @states = State.all
    @tickets = Ticket.where(nil)
    @tickets = @tickets.filter_department(filter_params[:filter_department_id]) if filter_params[:filter_department_id].present?
    @tickets = @tickets.filter_state(filter_params[:filter_state_id]) if filter_params[:filter_state_id].present?
    @tickets = @tickets.filter_subject(filter_params[:search]) if filter_params[:search].present?
    @tickets = @tickets.order(:id => :desc).paginate(:page => params[:page], :per_page => 5)
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
        UserMailer.ticket_added_email(ticket_params).deliver
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
      @ticket = Ticket.find(params[:id])
    end

    def ticket_params
      params.require(:ticket).permit(:client_name, :client_email, :subject, :body, :department_id,
                                     :uniq_reference, :state_id, :ticket)
    end

    def filter_params
      params.permit(:ticket, :filter_department_id, :filter_state_id, :filter_owner_id, :search)
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
