# frozen_string_literal: true

module Api
  module V1
    class UsersController < BaseController
      def me
        render json: UserBlueprint.render(current_user), status: :ok
      end
    end
  end
end
