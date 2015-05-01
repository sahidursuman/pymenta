module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end


  def language_links
        links = []
        I18n.available_locales.each do |locale|
          locale_key = "translation.#{locale}"
          if locale == I18n.locale
            links << link_to(I18n.t(locale_key), "#")
          else
            links << link_to(I18n.t(locale_key), url_for(locale: locale.to_s))
          end
        end
        links
      end 

   def display_status status
     if status == "NOT_PAID"
          html = "<td><span class='label label-important'>" + t('helpers.labels.NOT_PAID') + "</span></td>"
      elsif status == "PARTIAL_PAID"
          html = "<td><span class='label label-warning'>" + t('helpers.labels.PARTIAL_PAID') + "</span></td>"
      elsif status == "PAID"
          html = "<td><span class='label label-success'>" + t('helpers.labels.PAID') + "</span></td>"
      end
      html.html_safe
    end  

end
