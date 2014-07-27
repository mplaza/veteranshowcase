class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :author, :publication, :url, :favorite, :image, :publish_date, :approved, :saved   
end
