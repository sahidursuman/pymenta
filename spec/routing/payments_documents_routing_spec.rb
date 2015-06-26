require "spec_helper"

describe PaymentsDocumentsController do
  describe "routing" do

    it "routes to #index" do
      get("/payments_documents").should route_to("payments_documents#index")
    end

    it "routes to #new" do
      get("/payments_documents/new").should route_to("payments_documents#new")
    end

    it "routes to #show" do
      get("/payments_documents/1").should route_to("payments_documents#show", :id => "1")
    end

    it "routes to #edit" do
      get("/payments_documents/1/edit").should route_to("payments_documents#edit", :id => "1")
    end

    it "routes to #create" do
      post("/payments_documents").should route_to("payments_documents#create")
    end

    it "routes to #update" do
      put("/payments_documents/1").should route_to("payments_documents#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/payments_documents/1").should route_to("payments_documents#destroy", :id => "1")
    end

  end
end
