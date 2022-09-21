class Quote < ApplicationRecord
  has_many :line_item_dates, dependent: :destroy
  has_many :line_items, through: :line_item_dates
  belongs_to :company
  validates :name, presence: true

  scope :ordered, -> { order(id: :desc) }


  broadcasts_to ->(quote) { [quote.company, "quotes"] }, inserts_by: :prepend

  # Equivalent to the above line
  # after_create_commit -> { broadcast_prepend_later_to "quotes" }
  # after_update_commit -> { broadcast_replace_later_to "quotes" }
  # after_destroy_commit -> { broadcast_remove_to "quotes" }
  
  # Equivalent to the above line. Rails automatically set those as default values
  # after_create_commit -> { broadcast_prepend_to "quotes", partial: "quotes/quote", locals: { quote: self }, target: "quotes" }

  def total_price
    line_items.sum(&:total_price)
  end
  
end
