json.extract! course, :id, :name, :prerequisite, :user_id, :category_id, :created_at, :updated_at
json.url course_url(course, format: :json)
