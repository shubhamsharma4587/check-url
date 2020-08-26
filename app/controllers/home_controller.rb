class HomeController < ApplicationController

  def index
  end

  def upload
    # Reading the Uploaded file
    require 'roo'
    xlsx = Roo::Spreadsheet.open(params[:excel][:file].tempfile.to_path.to_s)
    sheet = xlsx.sheet(0)


    # Creating the results Excel File with Basic Data
    require 'spreadsheet'
    Spreadsheet.client_encoding = 'UTF-8'
    book = Spreadsheet::Workbook.new
    sheet_name = Integer(1e3 * Time.now.to_f).to_s
    result_sheet = book.create_worksheet
    result_sheet.name = "Result"
    result_sheet.row(0).push "Row no.", "Referral URL", "Landing Page URL"

    result_file_index = 1

    ((sheet.first_row + 1)..sheet.last_row).each_with_index do |row, index|
      referral_url = sheet.cell(row, 'A')
      landing_page_url = sheet.cell(row, 'B')

      response = HTTParty.get(referral_url)

      if response.body.include?(landing_page_url)
        result_sheet.row(result_file_index).push index + 2, referral_url, landing_page_url
        result_file_index += 1
      end
    end

    # Save Uploaded & Result Excel in public/results folder
    dir = Rails.root.join('public', 'results')
    Dir.mkdir(dir) unless Dir.exist?(dir)
    File.open(dir.join("#{sheet_name}.xlsx"), 'wb') do |file|
      file.write(params[:excel][:file].read)
    end
    book.write dir.join("#{sheet_name}_results.xlsx")

    # Send mail
    emails =  params[:email].split(' ').join().split(',')
    MailResultsMailer.send_mail(emails, "public/results/#{sheet_name}_results.xlsx").deliver_now
  end
end
