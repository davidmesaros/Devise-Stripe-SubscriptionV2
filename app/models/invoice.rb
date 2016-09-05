# class Invoice < ActiveRecord::Base
#   include Payday::Invoiceable
  
#   has_many :line_items
# end

# invoice = Payday::Invoice.new(:invoice_number => 12)
# invoice.line_items << Payday::LineItem.new(:price => 20, :quantity => 5, :description => "Pants")
# invoice.line_items << Payday::LineItem.new(:price => 10, :quantity => 3, :description => "Shirts")
# invoice.line_items << Payday::LineItem.new(:price => 5, :quantity => 200, :description => "Hats")
# invoice.render_pdf_to_file("/path/to_file.pdf")