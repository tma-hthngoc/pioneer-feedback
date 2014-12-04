class Feedback
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :subject, :from, :msg

  #validates :subject, :presence => true
  #validates :msg, :presence => true
  #validates_format_of :from, :with => /(?>(?:[0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+)[a-zA-Z]{2,9}/, :allow_blank => true
  validates_length_of :msg, :maximum => 500

  validate do |feedback|
    feedback.errors.add(:base, "Subject can't be blank") if feedback.subject.blank?
    feedback.errors.add(:base, "Feedback's content can't be blank") if feedback.msg.blank?
  end

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  private
  # Using a private method to encapsulate the permissible parameters is just a good pattern
  # since you'll be able to reuse the same permit list between create and update. Also, you
  # can specialize this method with per-user checking of permissible attributes.
  def feedback_params
    params.require(:contact).permit(:subject, :from, :msg)
  end
end
