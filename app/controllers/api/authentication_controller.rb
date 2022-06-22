class Api::AuthenticationController < ApplicationController
    skip_before_action :authenticate_request

    def authenticate
        hash = Api::Authentication::AuthenticateService.perform(params)

        if hash
            render json: { auth_token: hash }
        else
            render status: :unauthorized
        end
    end
end
