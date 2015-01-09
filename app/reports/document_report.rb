class DocumentReport < PdfReport
  TABLE_WIDTHS = [50, 200, 60, 120]
  RAILS_ROOT = Rails.root

  def initialize(document,user)
    super()
    @document = document
    @user = user

    logo
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

end