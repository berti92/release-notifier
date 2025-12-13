class NotificationsController < ApplicationController

    def index
        @notifications = Notification.order(:name)
    end

    def new
        @notification = Notification.new
        @notification.repo_type = :github
    end

    def edit
        @notification = Notification.find_by_hashid(params[:id]) rescue nil
    end

    def create
        @notification = Notification.new
        @notification.attributes = notification_params
        if @notification.save
            redirect_to notifications_path
        else
            render 'new'
        end
    end

    def duplicate
        @notification = Notification.find_by_hashid(params[:id]) rescue nil
        @notification = @notification.dup
        @notification.name += ' (duplicated)'
        @notification.save
        redirect_to notifications_path
    end

    def update
        @notification = Notification.find_by_hashid(params[:id]) rescue nil
        if @notification.update(notification_params)
            redirect_to notifications_path
        else
            render 'edit'
        end
    end

    def destroy
        @notification = Notification.find_by_hashid(params[:id]) rescue nil
        if @notification.destroy
            redirect_to notifications_path
        else
            render 'edit'
        end
    end

    def notification_params
        params.require(:notification).permit(:name, :repo_type, :repo, :email, :webhook_url, :webhook_method, :webhook_content_type, :webhook_payload, :stop_words)
    end

end
