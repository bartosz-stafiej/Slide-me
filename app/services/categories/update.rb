# frozen_string_literal: true

module Categories
  class Update
    def call(course:, data:)
      update_course(course, data)
      Services::Result.new(output: course)
    end

    private

    def update_course(course, data)
      course.update!(data)
      course
    end
  end
end
