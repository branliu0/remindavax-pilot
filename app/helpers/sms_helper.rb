module SmsHelper
  def send_reminder(patient, appointment)
    msg = appointment.sms_message
    send_sms(patient.mobile, msg)
    Sms.create!(:message => msg, :patient_id => patient.id, :appointment_id => appointment.id)
  end

  private

  # TODO: Abstract this to a config file? Right now this seems fine.
  BASE_SEND_URL = "http://bulk.smsinfy.com/web2sms.php?username=alex123&password=alex123&sender=KARUNA"
  def send_sms(mobile, message)
    url = BASE_SEND_URL + "&to=#{mobile}&message=#{CGI::escape(message)}"
    curl = Curl::Easy.http_get(url)
  end
end
