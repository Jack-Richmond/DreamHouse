require 'httparty'

class Flat < ApplicationRecord
  before_create :fetch_random_image
  validates :name, presence: true

  def fetch_random_image
    response = HTTParty.get('https://api.unsplash.com/photos/random', query: {
      client_id: '43ngdHYrbnr8GoAKFjcL9medEWHuioPaoL9KWGdF0is',
      query: 'apartments, houses'
    })

    if response.success?
      self.picture_url = response.parsed_response['urls']['regular']
    else
      Rails.logger.error("Failed to fetch random image: #{response.code}, #{response.message}")
    end
  end

  def location
    return unless address.present?

    address_parts = address.split(',')
    address_parts[1].strip if address_parts.size >= 2
  end
end
