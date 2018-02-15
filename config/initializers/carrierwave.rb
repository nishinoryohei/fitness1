CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: 'AKIAIL7V7AA3WTOJE6WA',
    aws_secret_access_key: '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',
    region: 'ap-northeast-1'
  }

  config.fog_directory  = 'fitness1'
  config.cache_storage = :fog
end
