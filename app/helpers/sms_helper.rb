module SmsHelper
  def send_reminder(appointment)
    msg = appointment.sms_message
    send_sms(appointment.patient.mobile, msg)
    appointment.sms.create!(:message => msg)
  end

  # TODO: Abstract this to a config file? Right now this seems fine.
  # BASE_SEND_URL = "http://bulk.smsinfy.com/web2sms.php?username=alex123&password=alex123&sender=KARUNA"
  BASE_SEND_URL = "http://bulk.smsinfy.com/web2sms.php?username=karuna&password=karuna123&sender=KARUNA"
  def send_sms(mobile, message)
    url = BASE_SEND_URL + "&to=#{mobile}&message=#{CGI::escape(message)}"
    curl = Curl::Easy.http_get(url)
  end

  # Make a class method copy of the method so that other class methods can
  # call this
  def self.send_sms(mobile, message)
    url = BASE_SEND_URL + "&to=#{mobile}&message=#{CGI::escape(message)}"
    curl = Curl::Easy.http_get(url)
  end
end
