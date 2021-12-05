# frozen_string_literal: true

module Categories
  class Create
    def call(data:, user: nil)
      category = create_category(user, data)
      Services::Result.new(output: category)
    end

    private

    def create_category(user, data)
      Category.create!(creator_id: user.id,
                       **data)
    end
  end
end
