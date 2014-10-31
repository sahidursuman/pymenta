require "spec_helper"

describe DocumentLinesController do
  describe "routing" do

    it "routes to #index" do
      get("/document_lines").should route_to("document_lines#index")
    end

    it "routes to #new" do
      get("/document_lines/new").should route_to("document_lines#new")
    end

    it "routes to #show" do
      get("/document_lines/1").should route_to("document_lines#show", :id => "1")
    end

    it "routes to #edit" do
      get("/document_lines/1/edit").should route_to("document_lines#edit", :id => "1")
    end

    it "routes to #create" do
      post("/document_lines").should route_to("document_lines#create")
    end

    it "routes to #update" do
      put("/document_lines/1").should route_to("document_lines#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/document_lines/1").should route_to("document_lines#destroy", :id => "1")
    end

  end
end
