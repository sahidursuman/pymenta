require 'prawn/table'
require 'open-uri'

class RetentionReport < PdfReport
  include ActionView::Helpers::NumberHelper
  TABLE_WIDTHS = [40, 70, 70, 70, 70, 70, 70, 70, 70, 70, 70, 70, 70]
  PAGE_MARGIN = [40, 40, 40, 40]
  RAILS_ROOT = Rails.root

  def initialize(payment_document,documents=[],user)
    super(:page_size => "LEGAL",  margin: PAGE_MARGIN, :page_layout => :landscape)
    @payment_document = payment_document
    @invoices = documents
    @user = user
    custom_box 'NRO. DE COMPROBANTE',@payment_document.number,570,310
    move_down 40
    custom_box 'FECHA DE EMISION',@payment_document.date.strftime('%d/%m/%Y').to_s,570,310
    move_down 40
    custom_box 'PERIODO FISCAL','ANO:' + (@payment_document.year-1900).to_s + '      MES:' + (@payment_document.month-1).to_s,570,310

    move_up 80
    logo

    text 'Ley IVA - ART 11: Seran responsables del pago del impuesto en calidad de agente de retencion,',:size => 10  
    text 'los comprobantes o adquirientes de determinados bienes muebles y los receptores de ciertos servicios,',:size => 10
    text 'a quienes la Administracion Tributaria designe como tal',:size => 10
    move_down 20
    text 'COMPROBANTE DE RETENCION DEL IMPUESTO AL VALOR AGREGADO',:size => 14, :style => :bold
    custom_box 'NOMBRE O RAZON SOCIAL AGENTE DE RETENCION',@user.company.name.upcase,0,440
    custom_box 'RIF DEL AGENTE DE RETENCION',(@user.company.id_number1.nil? ? '' : @user.company.id_number1.upcase),440,440
    move_down 40
    custom_box 'DIRECCION FISCAL DEL AGENTE DE RETENCION',(@user.company.address.nil? ? '' : @user.company.address.upcase),0,880
    move_down 40
    custom_box 'NOMBRE O RAZON SOCIAL SUJETO RETENIDO',@payment_document.account.name.upcase,0,440
    custom_box 'RIF DEL SUJETO RETENIDO',@payment_document.account.id_number1.upcase,440,440
    move_down 60
    display_header_table
    display_invoice_table
    display_total_table

    draw_text '______________________________', :at => [150, 35]
    draw_text 'FIRMA DEL BENEFICIARIO', :style => :bold, :at => [170, 15]   
    
    draw_text '______________________________', :at => [450, 35]
    draw_text 'FIRMA DEL AGENTE RETENEDOR', :style => :bold, :at => [450, 15]
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
      data = [['Oper. Nro.', 'Fecha de la Factura', 'Nro. de Factura', 'Nro. de Control', 'Tipo de Transacc.','Nro. de Factura Afectada', 'Total con IVA', 'Compras sin Credito Fiscal', 'Base Imponible', '% Alicuota', 'Impuesto IVA', '% de Retencion','IVA Retenido']]
#      data = [%w[OPER FECHA_DE_FACTURA NRO_DE_FACTURA NRO_DE_CONTROL NRO_DE_FACTURA_AFECTADA TOTAL_CON_IVA COMPRAS_SIN_CREDITO_FISCAL BASE_IMPONIBLE ALICUOTA IVA %RETENCION IVA_RETENIDO]]
      table(data, :row_colors => ["F0F0F0"],column_widths: TABLE_WIDTHS, :cell_style => { size: 10 } )
  end

  def display_invoice_table
    if table_data.empty?
      text "Ninguna factura encontrada"
    else
      table(table_data,column_widths: TABLE_WIDTHS, :cell_style => { size: 10 } )
    end
  end

  def table_data
    @table_data ||= @invoices.map { |e| [1, e.date.strftime('%d/%m/%Y'), e.document_number, e.control_number, "01-reg","", format_currency(e.total), "", format_currency(e.sub_total), e.tax, format_currency(e.tax_total), e.payments_document.percentage*100, format_currency(e.payments_document.percentage*e.tax_total)] }
  end

  def display_total_table
      data = [['', '', '', '', '','TOTALES', format_currency(@payment_document.total), '', format_currency(@payment_document.sub_total), '', format_currency(@payment_document.tax_total), '',format_currency(@payment_document.retention_total)]]
      table(data, column_widths: TABLE_WIDTHS, :cell_style => { size: 10 , :font_style => :bold } )
  end
  
  def format_currency(value)
    number_to_currency(value, unit: '', separator: ',' , delimiter: '.', format: "%u %n")  
  end
    

end