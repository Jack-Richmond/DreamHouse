require 'httparty'

class Flat < ApplicationRecord
  before_create :fetch_random_images
  validates :name, presence: true

  serialize :picture_urls, Array, coder: JSON

  def fetch_random_images
    response = HTTParty.get('https://api.unsplash.com/photos/random', query: {
      client_id: '43ngdHYrbnr8GoAKFjcL9medEWHuioPaoL9KWGdF0is',
      query: 'apartments, houses',
      count: 5
    })

    if response.success?
      self.picture_urls = response.parsed_response.map { |photo| photo['urls']['regular'] }
    else
      Rails.logger.error("Failed to fetch random images: #{response.code}, #{response.message}")
    end
  end

  def large_picture_url
    'large.jpg'
  end

  def small_picture_urls
    ['room1.jpg', 'rom2.jpg', 'room3.jpg', 'room4.jpg']
  end
end
