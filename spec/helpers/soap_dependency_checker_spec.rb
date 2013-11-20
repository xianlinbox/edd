require File.dirname(__FILE__)+'/../../helpers/soap_dependency_checker'
require File.dirname(__FILE__)+'/../../models/init'

describe 'Soap Dependency Checker' do
  it 'should success when validate a valid soap service' do

    def fake_request
      %Q{<?xml version="1.0" encoding="UTF-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:echo="http://www.without-brains.net/echo">
   <soapenv:Body>
      <echo:EchoRequest>
         <echo:Message>Hello World!</echo:Message>
      </echo:EchoRequest>
   </soapenv:Body>
</soapenv:Envelope>}
    end

    def expect_response
      %Q{
<SOAP:Envelope xmlns:SOAP="http://schemas.xmlsoap.org/soap/envelope/" xmlns:echo="http://www.without-brains.net/echo">
  <SOAP:Body>
    <echo:EchoResponse>
      <echo:Message>Hello World!</echo:Message>
    </echo:EchoResponse>
  </SOAP:Body>
</SOAP:Envelope>}
    end


    soap_dependency = SoapDependency.create(:name => "test",
    :endpoint => "http://localhost:9292/echo_service",
    :username => "admin",
    :password => "admin",
    :request => fake_request,
    :response => expect_response,
    :timeout => 5)

    SoapDependencyChecker.validate(soap_dependency).should eq 'success'
  end
end