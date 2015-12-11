require "rails_helper"

RSpec.describe ServicePaymentsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/service_payments").to route_to("service_payments#index")
    end

    it "routes to #new" do
      expect(:get => "/service_payments/new").to route_to("service_payments#new")
    end

    it "routes to #show" do
      expect(:get => "/service_payments/1").to route_to("service_payments#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/service_payments/1/edit").to route_to("service_payments#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/service_payments").to route_to("service_payments#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/service_payments/1").to route_to("service_payments#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/service_payments/1").to route_to("service_payments#destroy", :id => "1")
    end

  end
end
