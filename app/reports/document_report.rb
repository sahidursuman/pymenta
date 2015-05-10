class DocumentReport < PdfReport
  include ActionView::Helpers::NumberHelper
  TABLE_WIDTHS = [100, 200, 60, 60, 60, 60]
  RAILS_ROOT = Rails.root
  PAGE_MARGIN = [30, 30, 30, 30]

  def initialize(document,user)
    super(:page_size => "LETTER",  margin: PAGE_MARGIN, :page_layout => :portrait)
    @document = document
    @user = user
    define_grid(:columns => 2, :rows => 8, :gutter => 25)
    #grid.show_all
    logo
    grid(0,1).bounding_box do
      text document.type + " N# " + document.document_number, :size => 14, :style => :bold
      text "FECHA " + document.date.strftime('%d/%m/%Y'), :size => 10
      text "COND DE PAGO " + document.due, :size => 10
    end 
    company = @user.company
    grid(1,0).bounding_box do
      text ""
      text company.name, :style => :bold
      text company.id_number1, :size => 9
      text company.address, :size => 9
      text company.city, :size => 9
      text company.telephone, :size => 9
    end
    grid(1,1).bounding_box do
      text "CLIENTE", :style => :bold
      text document.account.name, :style => :bold
      text document.account.id_number1, :size => 9
      text document.account.address, :size => 9
      text document.account.city, :size => 9
      text document.account.telephone, :size => 9
    end  
    move_down 10
    display_header_table
    display_lines_table
    footer
  end

  private

  

  def logo
    puts "directory RAILS_ROOT = #{RAILS_ROOT}"
    if "#{RAILS_ROOT}" == "/app"
      image open(@user.company.logo.url(:square).sub(/\?.+\Z/, '')), :width => 225, :height => 60
    else
      image "#{RAILS_ROOT}/public"+@user.company.logo.url(:square).sub(/\?.+\Z/, ''), :width => 225, :height => 60
    end
  end

  def display_header_table
      data = [%w[COD DESCRIPCION UND CANT PRECIO TOTAL]]
      table(data, :row_colors => ["F0F0F0"],column_widths: TABLE_WIDTHS)
  end

  def display_lines_table
    if table_data.empty?
      text "No Lines Found"
    else
      table(table_data,column_widths: TABLE_WIDTHS,:cell_style => {:borders => [], size: 10})
    end
  end

  def table_data
    @table_data ||= @document.document_lines.map { |e| [e.code, e.description, e.product.units, e.in_quantity + e.out_quantity, format_currency(e.price), format_currency(e.total)] }
  end

  def footer
    grid(7,0).bounding_box do
      text "SUB-TOTAL", :align => :right, :style => :bold, :size => 18 
      text "IVA " + " " + @document.tax.to_s + " % ", :align => :right, :style => :bold, :size => 18
      text "TOTAL", :align => :right, :style => :bold, :size => 18 
    end
    grid(7,1).bounding_box do
      text format_currency(@document.sub_total).to_s, :align => :right, :size => 18
      text format_currency(@document.tax_total).to_s, :align => :right, :size => 18
      text format_currency(@document.total).to_s, :align => :right, :size => 18
    end
  end      
    
  def format_currency(value)
    number_to_currency(value, unit: '', separator: ',' , delimiter: '.', format: "%u %n")  
  end   
    
    
end