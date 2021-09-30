class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome
    @greeting = "Hi"
    @user = params[:user] # Instance variable => available in view
    mail(to: @user.email, subject: 'Welcome to Taskete')
  end

  # def email_notification
  #   @user = params[:user]
  #   @task = params[:task]
  #   mail(to: @user.email, subject: 'You have new task!', body: "#{@task.title}")
  # end

  def task_notification
    @user = params[:recipient]
    @task = params[:task]
    mail(to: @user.email, subject: 'You have new task!', locals: { task: @task }, template_path: 'app/views/devise/mailer/new_task_notification.html.erb')
  end
end
