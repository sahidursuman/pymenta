require "spec_helper"

describe DocumentTypesController do
  describe "routing" do

    it "routes to #index" do
      get("/document_types").should route_to("document_types#index")
    end

    it "routes to #new" do
      get("/document_types/new").should route_to("document_types#new")
    end

    it "routes to #show" do
      get("/document_types/1").should route_to("document_types#show", :id => "1")
    end

    it "routes to #edit" do
      get("/document_types/1/edit").should route_to("document_types#edit", :id => "1")
    end

    it "routes to #create" do
      post("/document_types").should route_to("document_types#create")
    end

    it "routes to #update" do
      put("/document_types/1").should route_to("document_types#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/document_types/1").should route_to("document_types#destroy", :id => "1")
    end

  end
end
