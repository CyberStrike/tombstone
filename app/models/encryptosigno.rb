require 'openssl'
require 'encrypto_signo'
require 'secureRandom'

#gernerating key pairs
keypair = EncryptoSigno.generate_keypair
private_key = keypair.to_s
public_key  = keypair.public_key.to_s

#signing of private key
token = SecureRandom.base64
signature = EncryptoSigno.sign(private_key, token)

sig_join = signature.split.join
signature_by_2 = (sig_join.size / 2)

user1_key = sig_join[0..signature_by_2]
user2_key = sig_join[(signature_by_2 + 1)..sig_join.size]


#after user is deseased a claim key is used to unlock account

claim_key = user1_key + user2_key
claim_key2 = user2_key + user1_key


#matches claim key to original key
if sig_join == claim_key
  p "ok"
  p EncryptoSigno.verify(public_key, claim_key, token)
elsif sig_join == claim_key2
  p "ok"
  p EncryptoSigno.verify(public_key, claim_key2, token)
else
  p "retry"
end 