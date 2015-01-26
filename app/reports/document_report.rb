class DocumentReport < PdfReport
  TABLE_WIDTHS = [60, 210, 60, 70, 70, 70]
  RAILS_ROOT = Rails.root

  def initialize(document,user)
    super()
    @document = document
    @user = user
    define_grid(:columns => 3, :rows => 8, :gutter => 10)
    #grid.show_all
    logo
    grid(0,2).bounding_box do
      text document.type + " N# " + document.document_number, :size => 14, :style => :bold
      text "FECHA " + document.date.to_s, :size => 10
      text "COND DE PAGO " + document.due, :size => 10
    end 
    company = @user.company
    grid(1,0).bounding_box do
      text ""
      text company.name, :style => :bold
      #text document.id_number1
      text company.address, :size => 10
      #text document.city + " " + document.state
      #text document.telephone
    end
    grid(1,2).bounding_box do
      text "CLIENTE", :style => :bold
      text document.account.name, :style => :bold
      text document.id_number1, :size => 10
      text document.address, :size => 10
      text document.city, :size => 10
      text document.telephone, :size => 10
    end  
    display_header_table
    display_lines_table
    footer
  end

  private

  

  def logo
    image "#{RAILS_ROOT}/public"+@user.company.logo.url(:square).sub(/\?.+\Z/, ''), :width => 250, :height => 100
  end

  def display_header_table
      data = [%w[CODE DESCRIPTION UNITS QUANTITY PRICE TOTAL]]
      table(data, :row_colors => ["F0F0F0"],column_widths: TABLE_WIDTHS)
  end

  def display_lines_table
    if table_data.empty?
      text "No Lines Found"
    else
      table(table_data,column_widths: TABLE_WIDTHS,:cell_style => {:borders => []})
    end
  end

  def table_data
    @table_data ||= @document.document_lines.map { |e| [e.code, e.description, e.product.units, e.in_quantity + e.out_quantity, e.price, e.total] }
  end

  def footer
    grid(7,1).bounding_box do
      text "SUB-TOTAL", :align => :right, :style => :bold, :size => 18 
      text "IVA " + " " + @document.tax.to_s + " % ", :align => :right, :style => :bold, :size => 18
      text "TOTAL", :align => :right, :style => :bold, :size => 18 
    end
    grid(7,2).bounding_box do
      text @document.sub_total.to_s, :align => :right, :size => 18
      text @document.tax_total.to_s, :align => :right, :size => 18
      text @document.total.to_s, :align => :right, :size => 18
    end
  end      
    
    
    
    
end