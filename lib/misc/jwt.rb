require 'jwt'

class JsonWebtoken
  PRIVATE_KEY = 'haha'

  def self.encode(payload)
    JWT.encode(payload, PRIVATE_KEY)
  end

  def self.decode(token)
    JWT.decode(token, PRIVATE_KEY)
  end
end

jwt = JsonWebtoken.encode({ user_id: 1 })
puts jwt
payload, header = JsonWebtoken.decode(jwt)
puts payload
puts header

# Server always knows private key
# If the token has been tampered with the decoding will fail.
