json.extract! question, :id, :subgenre_id, :description, :option1, :option2, :option3, :option4, :correct1, :correct2, :correct3, :correct4, :created_at, :updated_at
json.url question_url(question, format: :json)
