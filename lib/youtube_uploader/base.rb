require 'rubygems'
# gem 'google-api-client'
require 'google/api_client'
require 'google/api_client/client_secrets'
require 'google/api_client/auth/file_storage'
require 'google/api_client/auth/installed_app'
Faraday.default_adapter = :httpclient

module YoutubeUploader
  class Base
    # A limited OAuth 2 access scope that allows for uploading files, but not other
    # types of account access.
    # YOUTUBE_UPLOAD_SCOPE = 'https://www.googleapis.com/auth/youtube.upload'
    YOUTUBE_API_SERVICE_NAME = 'youtube'
    YOUTUBE_API_VERSION = 'v3'

    def get_authenticated_service
      client = Google::APIClient.new(:application_name => 'VideoBook', :application_version => '0.0.1')
      key = Google::APIClient::KeyUtils.load_from_pkcs12("#{Rails.root.to_s}/config/keys/privatekey.p12", 'notasecret')
      client.authorization = Signet::OAuth2::Client.new(:token_credential_uri => 'https://accounts.google.com/o/oauth2/token', 
        :audience => 'https://accounts.google.com/o/oauth2/token', 
        :scope => 'https://www.googleapis.com/auth/youtube', 
        :issuer => '252100592954-iammj6c5ha0809m5p3733pbref72fivc@developer.gserviceaccount.com', 
        :signing_key => key, :person => 'sembryonics@gmail.com')
      client.authorization.fetch_access_token!
      youtube = client.discovered_api(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION)

      return client, youtube
    end

    def upload(opts)
      default_opts = {:keywords => "", :category_id => 22, :privacy_status => 'public'}
      opts.merge!(default_opts)

      client, youtube = get_authenticated_service

      begin
        body = {
          :snippet => {
            :title => opts[:title],
            :description => opts[:description],
            :tags => opts[:keywords].split(','),
            :categoryId => opts[:category_id],
          },
          :status => {
            :privacyStatus => opts[:privacy_status]
          }
        }

        videos_insert_response = client.execute!(
          :api_method => youtube.videos.insert,
          :body_object => body,
          :media => Google::APIClient::UploadIO.new(opts[:file], 'video/*'),
          :parameters => {
            :uploadType => 'resumable',
            :part => body.keys.join(',')
          }
        )

        videos_insert_response.resumable_upload.send_all(client)

        puts "Video id '#{videos_insert_response.data.id}' was successfully uploaded."
        return videos_insert_response
      rescue Google::APIClient::TransmissionError => e
        puts e.result.body
      end
    end
  end
end