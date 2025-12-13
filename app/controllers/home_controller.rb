class HomeController < ApplicationController

    skip_before_action :verify_authenticity_token, :only => [:paddle_webhook]

    def index
    end

    def privacy_notice
    end

    def block_mail
        unless params[:remove].blank? && BlockedMail.where(mail_address: params[:mail]).count == 0
            BlockedMail.create(mail_address: params[:mail])
        end
    end

    def subscription
    end

    def thanks
    end
    
    def unsubscribed
    end

    def terms
    end

end
