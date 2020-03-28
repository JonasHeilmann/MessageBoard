FactoryBot.define do
  factory :user, class: User do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end

FactoryBot.define do
  factory :random_message, class: Message do
    title { Faker::Lorem.sentence(word_count: 3, supplemental: false, random_words_to_add: 4) }
    description { Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4) }
    user
  end
end