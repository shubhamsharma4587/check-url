class MailResultsMailer < ApplicationMailer

  def send_mail(emails, excel_path)
    attachments["Result.xlsx"] = File.read(excel_path)
    mail(to: emails.join(','), subject: 'Results of uploaded excel')
  end

end
