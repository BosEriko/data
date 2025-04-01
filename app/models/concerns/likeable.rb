module Likeable
   extend ActiveSupport::Concern

   included do
     has_many :likes, as: :likeable, class_name: "Like", dependent: :destroy
   end
 end