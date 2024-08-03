class NotificationsController < ApplicationController
    before_action :set_notification, only: %i[show update destroy]
  
    # GET /notifications
    def index
      @notifications = Notification.all
      render json: @notifications
    end
  
    # GET /notifications/:id
    def show
      render json: @notification
    end
  
    # POST /notifications
    def create
      @notification = Notification.new(notification_params)
      if @notification.save
        render json: @notification, status: :created, location: @notification
      else
        render json: @notification.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /notifications/:id
    def update
      if @notification.update(notification_params)
        render json: @notification
      else
        render json: @notification.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /notifications/:id
    def destroy
      @notification.destroy
      head :no_content
    end
  
    private
  
    def set_notification
      @notification = Notification.find(params[:id])
    end
  
    def notification_params
      params.require(:notification).permit(:title, :message, :user_id, :status)
    end
  end
  