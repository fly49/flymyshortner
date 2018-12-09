class Link
  SHORT_LINK_LETTERS = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten.freeze
  include ActiveModel::Validations

  attr_accessor :url, :url_title

  validates :url, presence: true, url: true
  
  def self.get(key)
    Marshal.load(REDIS.get(key))
  end
  
  def scrap_title
    GetLinkTitleWorker.perform_async(@path_key)
  end
  
  def save_under_key
    key = nil
    loop do
      key = generate_key
      unless REDIS.exists(key)
        REDIS.set(key, Marshal.dump(@url))
        break
      end
    end
    scrap_title
    key
  end
  
  def persisted?
    REDIS.exists(@path_key)
  end
  
  def to_key
    @path_key ? @path_key : nil
  end
  
  def process_cookies(cookies)
    keys_arr = cookies ? JSON.parse(cookies) : []
    @path_key = select_existed(keys_arr) || save_under_key
    keys_arr << @path_key unless select_existed(keys_arr)
    JSON.generate(keys_arr)
  end
  
  def select_existed(keys_arr)
    return unless keys_arr.present?
    indexed_url = keys_arr.map{ |key| Link.get(key) }
                           .each_with_index
                           .select{ |url, i| (url == @url) || url.first == @url }
    keys_arr[indexed_url[0][1]] if indexed_url.present?
  end
  
  private

  def generate_key
    SHORT_LINK_LETTERS.sample(8).join
  end
end
