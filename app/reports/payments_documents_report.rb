require 'prawn/table'
require 'open-uri'

class PaymentsDocumentsReport < PdfReport
  include ActionView::Helpers::NumberHelper
  TABLE_WIDTHS = [60, 100, 100, 200, 80, 80, 80, 80, 90]
  PAGE_MARGIN = [40, 40, 40, 40]
  RAILS_ROOT = Rails.root

  def initialize(payments_documents=[],user, start_at, end_at)
    super(:page_size => "LEGAL",  margin: PAGE_MARGIN, :page_layout => :landscape)
    @payments = payments_documents
    @user = user
    logo
    move_down 40
    text 'Listado de Pagos desde ' + start_at.strftime('%d/%m/%Y') + ' hasta ' + end_at.strftime('%d/%m/%Y'),:size => 24, :style => :bold
    move_down 40
    display_header_table
    display_invoice_table
    display_total_table
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
      data = [['Fecha de la Retencion', 'Nro. de Comprobante', '% de Retencion','Nombre','Total con IVA', 'Base Imponible', 'Impuesto IVA', 'IVA Retenido', 'Estado']]
      table(data, :row_colors => ["F0F0F0"],column_widths: TABLE_WIDTHS, :cell_style => { size: 10 } )
  end

  def display_invoice_table
    if table_data.empty?
      text "Ningun Pago encontrado"
    else
      table(table_data,column_widths: TABLE_WIDTHS, :cell_style => { size: 10 } ) do
        cells.style do |c|
          if c.content == "NO PAGADO"
            c.background_color = 'b42121'
          elsif c.content == "PAGADO PARCIAL"
            c.background_color = 'ffad32'
          elsif c.content == "PAGADO"
            c.background_color = '2f960b'
          end              
        end
      end  
    end
  end

  def table_data
    @table_data ||= @payments.map { |e| [e.date.strftime('%d/%m/%Y'), e.number, e.percentage, e.name, format_currency(e.total), format_currency(e.sub_total), format_currency(e.tax_total),format_currency(e.retention_total), status_name(e.status)] }
  end

  def display_total_table
      data = [['', '', '', 'TOTALES', format_currency(@payments.sum("total")), format_currency(@payments.sum("sub_total")), format_currency(@payments.sum("tax_total")), format_currency(@payments.sum(&:retention_total)),'']]
      table(data, :row_colors => ["F0F0F0"],column_widths: TABLE_WIDTHS, :cell_style => { size: 10 , :font_style => :bold } )
  end
  
  def format_currency(value)
    number_to_currency(value, unit: '', separator: ',' , delimiter: '.', format: "%u %n")  
  end
    
  def status_name(value) 
    if value == nil || value == "NOT_PAID"
      "NO PAGADO"
    elsif value == "PARTIAL_PAID"
      "PAGADO PARCIAL"
    elsif value == "PAID"
      "PAGADO"
    end
  end
end
