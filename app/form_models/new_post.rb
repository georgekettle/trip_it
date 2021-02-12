module Wizard
  module NewPost
    STEPS = %w(step1 step2 step3).freeze

    # class Base
    #   include ActiveModel::Model
    #   attr_reader :post
    #   # delegate :title, to: :post

    #   def initialize(post_attributes)
    #     @post = Post.new(post_attributes)
    #   end

    #   def title
    #     @post.title
    #   end

    #   # attr_array = Post.attribute_names.map { |attr| [attr.to_sym, "#{attr}="] }.flatten
    #   # attr_array.each do |attr|
    #   #   delegate attr.to_sym, to: :@post
    #   # end
    # end

    class Base
      include ActiveModel::Model
      attr_accessor :post


      # delegate *::Post.attribute_names.map { |attr| [attr, "#{attr}="] }.flatten, to: :@post

      def initialize(user_attributes)
        @post = ::Post.new(user_attributes)
      end
      delegate :title, to: :@post
    end

    class Step1 < Base
      # delegate :photo_id, to: :@post
      validates :photo_id, presence: true

      def list_post
        @post
      end
    end

    class Step2 < Step1
      # delegate :location_id, to: :@post
      validates :location_id, presence: true
      # validates :first_name, presence: true
      # validates :last_name, presence: true
    end

    class Step3 < Step2
      # validates :address_1, presence: true
      # validates :zip_code, presence: true
      # validates :city, presence: true
      # validates :country, presence: true
    end

    class Step4 < Step3
      # validates :phone_number, presence: true
    end
  end
end
