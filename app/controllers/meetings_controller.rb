class MeetingsController < ApplicationController
    before_action :set_meeting, only: %i[show update destroy]

    # GET /meetings
    def index
      @meetings = Meeting.all
      render json: @meetings
    end

    # GET /meetings/:id
    def show
      render json: @meeting
    end

    # POST /meetings
    def create
      @meeting = Meeting.new(meeting_params)
      if @meeting.save
        render json: @meeting, status: :created, location: @meeting
      else
        render json: @meeting.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /meetings/:id
    def update
      if @meeting.update(meeting_params)
        render json: @meeting
      else
        render json: @meeting.errors, status: :unprocessable_entity
      end
    end

    # DELETE /meetings/:id
    def destroy
      @meeting.destroy
      head :no_content
    end

    private

    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    def meeting_params
      params.require(:meeting).permit(:title, :description, :scheduled_date, :reminder_date, :location)
    end
  end
  