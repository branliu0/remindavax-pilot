require 'spec_helper'

describe ApplicationController do
  describe "timezone" do
    it "should respond to the timezone properly" do
      here = Date.today
      request.cookies["time_zone"] = 15*60
      controller.method(:set_timezone).call
      Date.today.should != here
    end
  end
end
