class Acme::Client::Certificate
  extend Forwardable

  attr_reader :x509, :x509_chain, :request, :private_key

  def_delegators :x509, :to_pem, :to_der

  def initialize(certificate, chain, request)
    @x509 = certificate
    @x509_chain = chain
    @request = request
  end

  def chain_to_pem
    x509_chain.map(&:to_pem).join
  end

  def x509_fullchain
    [x509, *x509_chain]
  end

  def fullchain_to_pem
    x509_fullchain.map(&:to_pem).join
  end

  def common_name
    x509.subject.to_a.find {|name, _, _| name == "CN" }[1]
  end
end
