# frozen_string_literal: true

module Categories
  class Update
    def call(category:, data:)
      update_category(category, data)
      Services::Result.new(output: category)
    end

    private

    def update_category(category, data)
      category.update!(data)
      category
    end
  end
end
