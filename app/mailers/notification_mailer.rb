class NotificationMailer < ApplicationMailer
  def notify_mail(notification, link)
    @notification = notification
    @link = link
    @project_name = notification.repo
    if @project_name.blank? || @project_name == 'wrong_repo/format'
      @project_name = I18n.t('repo_types.' + notification.repo_type)
    end
    @subject = "#{@project_name} released a new version!"
    mail to: @notification.email, subject: @subject
  end
end
