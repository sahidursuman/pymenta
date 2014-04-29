require "spec_helper"

describe WarehousesController do
  describe "routing" do

    it "routes to #index" do
      get("/warehouses").should route_to("warehouses#index")
    end

    it "routes to #new" do
      get("/warehouses/new").should route_to("warehouses#new")
    end

    it "routes to #show" do
      get("/warehouses/1").should route_to("warehouses#show", :id => "1")
    end

    it "routes to #edit" do
      get("/warehouses/1/edit").should route_to("warehouses#edit", :id => "1")
    end

    it "routes to #create" do
      post("/warehouses").should route_to("warehouses#create")
    end

    it "routes to #update" do
      put("/warehouses/1").should route_to("warehouses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/warehouses/1").should route_to("warehouses#destroy", :id => "1")
    end

  end
end
