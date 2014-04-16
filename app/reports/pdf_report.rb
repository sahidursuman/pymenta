class PdfReport < Prawn::Document
  def initialize(default_prawn_options={})
    super(default_prawn_options)
  end
  def header(title=nil)
    if title
      text title, size: 14, style: :bold_italic, align: :center
    end
  end
  def footer
  end
end