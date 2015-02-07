class StatesController < ApplicationController
  before_action :set_state, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @states = State.all
    respond_with(@states)
  end

  def show
    respond_with(@state)
  end

  def new
    @state = State.new
    respond_with(@state)
  end

  def edit
  end

  def create
    @state = State.new(state_params)
    @state.save
    respond_with(@state)
  end

  def update
    @state.update(state_params)
    respond_with(@state)
  end

  def destroy
    @state.destroy
    respond_with(@state)
  end

  private
    def set_state
      @state = State.find(params[:id])
    end

    def state_params
      params.require(:state).permit(:name)
    end
end
