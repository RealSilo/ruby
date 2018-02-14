require 'openssl'
require 'base64'

def generate_key_pair
  key_pair = OpenSSL::PKey::RSA.new(2048)
  private_key, public_key = key_pair.export, key_pair.public_key
  [private_key, public_key]
end

def sign_message(message, raw_private_key)
  private_key = OpenSSL::PKey::RSA.new(raw_private_key)
  Base64.encode64(private_key.private_encrypt(message))
end

def decode_message(signed_message, raw_public_key)
  public_key = OpenSSL::PKey::RSA.new(raw_public_key)
  public_key.public_decrypt(Base64.decode64(signed_message))
end

def valid_signature?(message, signed_message, raw_public_key)
  decode_message(signed_message, raw_public_key) == message
end

private_key, public_key = generate_key_pair
message = 'haha'
puts private_key
puts public_key
signed_message = sign_message(message, private_key)
decoded_message = decode_message(signed_message, public_key)
puts decoded_message
puts valid_signature?(message, signed_message, public_key)
