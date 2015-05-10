class DocumentReport3 < PdfReport
 include ActionView::Helpers::NumberHelper
  TABLE_WIDTHS = [180, 230, 60, 60]
  PAGE_MARGIN = [50, 50, 30, 30]
  FONT_SIZE = 10
  TOP_MARGIN = 650
  LEFT_MARGIN = 80
  RAILS_ROOT = Rails.root


  def initialize(document,user)
    super(:page_size => "LETTER",  margin: PAGE_MARGIN, :page_layout => :portrait)

    @document = document
    @user = user
 
    draw_text (user.company.city.nil? ? '' : user.company.city.upcase.to_s) + "            " + document.date.day.to_s + "        " + document.date.month.to_s  + "       " + document.date.year.to_s, :size => FONT_SIZE, :at => [LEFT_MARGIN+300, TOP_MARGIN]   
    draw_text document.account.name.to_s, :size => FONT_SIZE, :at => [LEFT_MARGIN+80, TOP_MARGIN-40]  
    draw_text document.account.id_number1.to_s, :size => FONT_SIZE, :at => [LEFT_MARGIN+400, TOP_MARGIN-40]  
    draw_text document.account.address.to_s, :size => FONT_SIZE, :at => [LEFT_MARGIN, TOP_MARGIN-60]  
    draw_text document.account.city.to_s, :size => FONT_SIZE, :at => [LEFT_MARGIN, TOP_MARGIN-80]  
    draw_text document.account.state.to_s, :size => FONT_SIZE, :at => [LEFT_MARGIN+200, TOP_MARGIN-80]  
    draw_text document.account.telephone.to_s, :size => FONT_SIZE,  :at => [LEFT_MARGIN+320, TOP_MARGIN-80] 
 
    move_down 180
    display_lines_table
    move_cursor_to 100
    footer
  end

  private

  def display_lines_table
    if table_data.empty?
      text "No Lines Found"
    else
      table(table_data,column_widths: TABLE_WIDTHS, :cell_style => {:borders => [], :size => FONT_SIZE})
    end
  end

  def table_data
    @table_data ||= @document.document_lines.map { |e| [(e.in_quantity + e.out_quantity).to_s, e.description, format_currency(e.price), format_currency(e.total)] }
  end

  def footer
    text format_currency(@document.sub_total.to_s), :size => FONT_SIZE,  :align => :right 
    move_down 15
    text @document.tax.to_s + " %        " + format_currency(@document.tax_total.to_s), :size => FONT_SIZE, :align => :right 
    move_down 15
    text format_currency(@document.total.to_s), :size => FONT_SIZE, :align => :right 
  end      
  
  def format_currency(value)
    number_to_currency(value, unit: '', separator: ',' , delimiter: '.', format: "%u %n")  
  end  

    
end