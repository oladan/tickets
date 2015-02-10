class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show]
  respond_to :html
  helper_method :sort_column, :sort_direction

  def index
    @departments = Department.all
    @states = State.all
    @tickets = Ticket.where(nil)
    @tickets = @tickets.filter_department(filter_params[:filter_department_id]) if filter_params[:filter_department_id].present?
    @tickets = @tickets.filter_state(filter_params[:filter_state_id]) if filter_params[:filter_state_id].present?
    @tickets = @tickets.filter_subject(filter_params[:search]) if filter_params[:search].present?
    @tickets = @tickets.order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], :per_page => 5)
    respond_with(@tickets)
  end

  def new
    @ticket = Ticket.new
    respond_with(@ticket)
  end

  def edit
  end

  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      flash[:notice] = "Ticket created!"
      respond_with(@ticket)
      UserMailer.ticket_added_email(@ticket.client_email, @ticket.uniq_reference, 
                                    request.host_with_port + ticket_path(@ticket), @ticket.client_name).deliver
    else
      flash[:alert] = "Please fill in correctly all the fields"
      respond_with(@ticket)
    end
  end

  def show
    respond_with(@ticket)
  end

  private
    def set_ticket
      @ticket = Ticket.find_by uniq_reference: params[:id]
    end

    def ticket_params
      params.require(:ticket).permit(:client_name, :client_email, :subject, :body, :department_id,
                                     :uniq_reference, :state_id, :ticket)
    end

    def filter_params
      params.permit(:ticket, :filter_department_id, :filter_state_id, :filter_owner_id, :search, :order)
    end

    def sort_column
      Ticket.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
    end

end
