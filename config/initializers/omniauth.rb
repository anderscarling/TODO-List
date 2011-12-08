require 'openid/store/filesystem'

# Should handle CA certificates on Linux (at least Debian-ish Linux)
ca_path = "/etc/ssl/certs/ca-certificates.crt"
if File.readable?(ca_path)
  require "openid/fetchers"
  OpenID.fetcher.ca_file = ca_path
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :openid,
    name:       'google',
    identifier: 'https://www.google.com/accounts/o8/id',
    store:      OpenID::Store::Filesystem.new('/tmp')
end
