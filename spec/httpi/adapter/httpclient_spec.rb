require "spec_helper"
require "httpi/adapter/httpclient"
require "httpi/request"

require "httpclient"

describe HTTPI::Adapter::HTTPClient do
  let(:adapter) { HTTPI::Adapter::HTTPClient.new }

  describe ".new" do
    it "should require the HTTPClient gem" do
      HTTPI::Adapter::HTTPClient.any_instance.expects(:require).with("httpclient")
      HTTPI::Adapter::HTTPClient.new
    end
  end

  describe "#get" do
    before do
      @request = HTTPI::Request.new :url => "http://example.com"
      response = HTTP::Message.new_response Fixture.xml
      httpclient.expects(:get).with(@request.url, nil, @request.headers).returns(response)
    end

    it "should return a valid HTTPI::Response" do
      adapter.get(@request).should be_a_valid_httpi_response
    end
  end

  describe "#post" do
    before do
      @request = HTTPI::Request.new :url => "http://example.com", :body => Fixture.xml
      response = HTTP::Message.new_response Fixture.xml
      httpclient.expects(:post).with(@request.url, @request.body, @request.headers).returns(response)
    end

    it "should return a valid HTTPI::Response" do
      adapter.post(@request).should be_a_valid_httpi_response
    end
  end

  def httpclient
    HTTPClient.any_instance
  end

end
