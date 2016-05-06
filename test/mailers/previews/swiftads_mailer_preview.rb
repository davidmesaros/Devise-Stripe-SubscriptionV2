# Preview all emails at http://localhost:3000/rails/mailers/swiftads_mailer
class SwiftadsMailerPreview < ActionMailer::Preview
  def swiftads_mailer_preview
    SwiftadsMailer.swiftads_email(User.first)
  end

end
