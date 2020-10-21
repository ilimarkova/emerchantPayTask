require 'faker'

class Payment

    def create(url, payload, authorization = true)
        headers = {'content-type' => 'application/json;charset=UTF-8'}
        auth_header = {'Authorization' => "Basic #{AUTH_TOKEN}"}
        headers.merge!(auth_header) if authorization
        begin
           RestClient.post(url, payload.to_json, headers)
        rescue => exception
            exception.response
        end
    end    
end