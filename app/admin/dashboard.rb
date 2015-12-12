ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    div :class => "blank_slate_container", :id => "dashboard_default_message" do
    end
    columns do
      column do
        panel "Recent Companies" do
          table_for Company.order('id desc').limit(10) do
            column :name do |company|
              link_to company.name, [:admin, company]
            end
            column :id_number1
            column :city
            column :state
            column :country
            column :plan
            column :created_at
          end
        end
      end
      column do
        panel "Recent Users" do
          table_for User.order('id desc').limit(10).each do |user|
            column :name do |user|
              link_to user.company.name, [:admin, user.company]
            end      
            column :name do |user|
              link_to user.name, [:admin, user]
            end
            column :email
            column :created_at
          end
         end
       end
     end # columns       
     columns do
       column do
         panel "Recent Service Payments" do
           table_for ServicePayment.order("created_at desc").limit(5) do
             column :name do |service_payment|
               link_to service_payment.company.name, [:admin, service_payment.company]
             end
             column :id
             column :description
             column :amount
             column :method
             column :period
             column :created_at
           end
         end 
       end   
    end
    columns do
        column do
          div do
            br
            text_node %{<iframe src="https://rpm.newrelic.com/public/charts/6VooNO2hKWB" width="500" height="300" scrolling="no" frameborder="no"></iframe>}.html_safe
           end
        end
    end # columns
    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
