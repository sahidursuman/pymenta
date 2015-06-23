class Report1 < PdfReport
  include ActionView::Helpers::NumberHelper
  TABLE_WIDTHS = [160, 210, 80, 80]
  PAGE_MARGIN = [50, 50, 30, 30]
  FONT_SIZE = 13
  RAILS_ROOT = Rails.root


  def initialize(document,user)
    super(:page_size => "LETTER",  margin: PAGE_MARGIN, :page_layout => :portrait)
   # font_families.update(
   #   'Lucida' => { :normal => Rails.root.join('public/Lucida.ttf').to_s,
   #                 :bold   => Rails.root.join('public/Lucida2.ttf').to_s }
   # )
   # font "Lucida"
    @document = document
    @user = user
 
    draw_text document.date.day.to_s + "  /  " + document.date.month.to_s  + "  /  " + document.date.year.to_s, :size => FONT_SIZE, :style => :bold, :at => [120, 600]   
    draw_text document.account.name.to_s, :size => FONT_SIZE, :style => :bold, :at => [120+20, 560]  
    draw_text document.account.id_number1.to_s, :size => FONT_SIZE, :style => :bold, :at => [120+320, 560]  
    draw_text document.account.address.to_s.truncate(60,omission: ''), :size => FONT_SIZE, :style => :bold, :at => [120-60, 540]  
    draw_text document.account.city.to_s, :size => FONT_SIZE, :style => :bold, :at => [120, 520]  
    draw_text document.account.state.to_s, :size => FONT_SIZE, :style => :bold, :at => [120+150, 520]  
    draw_text (document.account.country.nil? ? '' : document.account.country.upcase.to_s), :size => FONT_SIZE, :style => :bold, :at => [120+320, 520]  
    draw_text document.account.telephone.to_s, :size => FONT_SIZE, :style => :bold, :at => [120, 500] 
    draw_text document.due.to_s, :size => FONT_SIZE, :style => :bold, :at => [120+320, 500]   
    move_down 260
    display_lines_table
    move_cursor_to 90
    footer
  end

  private

  def display_lines_table
    if table_data.empty?
      text "No Lines Found"
    else
      table(table_data,column_widths: TABLE_WIDTHS, :cell_style => {:borders => [], :size => FONT_SIZE, :font_style => :bold})
    end
  end

  def table_data
    @table_data ||= @document.document_lines.map { |e| [(e.in_quantity + e.out_quantity).to_s, e.description, format_currency(e.price), format_currency(e.total)] }
  end

  def footer
    text format_currency(@document.sub_total.to_s), :size => FONT_SIZE, :style => :bold, :align => :right 
    move_down 10
    text @document.tax.to_s + " %        " + format_currency(@document.tax_total.to_s), :size => FONT_SIZE, :style => :bold, :align => :right 
    move_down 10
    text format_currency(@document.total.to_s), :size => FONT_SIZE, :style => :bold, :align => :right 
  end      
  
  def format_currency(value)
    number_to_currency(value, unit: '', separator: ',' , delimiter: '.', format: "%u %n")  
  end  
    
    
    
end