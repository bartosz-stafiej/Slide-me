# frozen_string_literal: true

module Api
  module V1
    class CategoriesController < BaseController
      include Pagy::Backend

      def index
        @pagy, categories = pagy(Category.all, items: params[:items])

        render json: CategoryBlueprint.render(categories, root: :categories)
      end

      def create
        authorize! Category

        contract = Categories::CreateContract.new
        validation_results = validate!(contract)

        creator = Categories::Create.new
        result = creator.call(user: current_user,
                              data: validation_results.to_h)

        render json: CategoryBlueprint.render(result.output, root: :category),
               status: :created
      end

      def update
        authorize! Category

        category = Category.find(params[:id])
        contract = Categories::UpdateContract.new
        validation_results = validate!(contract)

        updator = Categories::Update.new
        result = updator.call(category: category,
                              data: validation_results.to_h)

        render json: CategoryBlueprint.render(result.output, root: :category)
      end

      def destroy
        authorize! Category

        category = Category.find(params[:id])
        category.destroy

        head :no_content
      end
    end
  end
end
