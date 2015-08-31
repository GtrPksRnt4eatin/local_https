require 'openssl'

def get_cert(state,city,org,unit,host)
  state ||= "NY"; city ||= "Melville"; org ||= "Steris"; unit ||= "VTSMedical"; host ||= "localhost" 
  name = "/C=US/ST=#{state}/L=#{city}/O=#{org}/OU=#{unit}/CN=#{host}"
  ca  = OpenSSL::X509::Name.parse(name)
  key = OpenSSL::PKey::RSA.new(1024)
  crt = OpenSSL::X509::Certificate.new
  crt.version = 2;  crt.serial = 1;
  crt.subject = ca; crt.issuer = ca;
  crt.public_key = key.public_key
  crt.not_before = Time.now
  crt.not_after = Time.now + 31536000 # 1 year
  {:crt => crt, :key => key }
end