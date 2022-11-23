# json.partial! "topics/topic", topic: @topic

json.topic do
  json.id @topic.id
  json.title @topic.title
end