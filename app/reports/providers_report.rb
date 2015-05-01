require 'prawn/table'
require 'open-uri'

class ProvidersReport < PdfReport
  include ActionView::Helpers::NumberHelper
  TABLE_WIDTHS = [100, 200, 200, 200, 200]
  PAGE_MARGIN = [40, 40, 40, 40]
  RAILS_ROOT = Rails.root

  def initialize(providers=[],user, code, name, city)
    super(:page_size => "LEGAL",  margin: PAGE_MARGIN, :page_layout => :landscape)
    @providers = providers
    @user = user
    @code = code
    @name = name
    @city = city
    logo
    move_down 40
    text 'Listado de Proveedores',:size => 24, :style => :bold
    move_down 40
    display_header_table
    display_invoice_table
    footer
  end

  private

  def custom_box(title,description,x,width)
    stroke_rectangle [0+x,cursor-20], width, 30
    text_box(title, :at=>[3+x,cursor-22], :width=>width, :height=>30, :size => 10,:style => :bold)
    text_box(description, :at=>[3+x,cursor-40], :width=>width, :height=>30, :size => 10)
  end
 
  def logo
    puts "directory RAILS_ROOT = #{RAILS_ROOT}"
    if "#{RAILS_ROOT}" == "/app"
      image open(@user.company.logo.url(:square).sub(/\?.+\Z/, '')), :width => 225, :height => 60
    else
      image "#{RAILS_ROOT}/public"+@user.company.logo.url(:square).sub(/\?.+\Z/, ''), :width => 225, :height => 60
    end
  end

  def display_header_table
      data = [['Codigo', 'Nombre', 'RIF','Telefono','Ciudad']]
      table(data, :row_colors => ["F0F0F0"],column_widths: TABLE_WIDTHS, :cell_style => { size: 10 } )
  end

  def display_invoice_table
    if table_data.empty?
      text "Ningun proveedor encontrado"
    else
      table(table_data,column_widths: TABLE_WIDTHS, :cell_style => { size: 10 } )
    end
  end

  def table_data
    @table_data ||= @providers.map { |e| [e.code, e.name, e.id_number1, e.telephone, e.city] }
  end

end
