# frozen_string_literal: true

module Types
  class QuestionType < Types::BaseObject
    field :id, ID, null: false
    field :question, String
    field :admin_user_id, Integer
    field :admin_user, Types::AdminUserType, null: false
    field :paper_id, Integer
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :comma_separated_keywords, String
    field :answer_generation_status, Integer
  end
end
