class Order < ActiveRecord::Base
  include AASM

  has_many :resources, :dependent => :destroy
  belongs_to :user

  serialize :transaction_details

  validates :price, :type_of_paper, :academic_level, :pages, presence: true

  aasm do
    state :new_order, :initial => true
    state :payment_pending
    state :in_progress
    state :delivered
    state :correcting
    state :completed

    event :create_completed do
      transitions :from => :new_order, :to => :payment_pending
    end

    event :payment_success do
      transitions :from => :payment_pending, :to => :in_progress
    end

    event :essay_written do
      transitions :from => :in_progress, :to => :delivered
    end

    event :essay_reject do
      transitions :from => :delivered, :to => :correcting
    end

    event :essay_approved do
      transitions :from => [:correcting, :in_progress], :to => :completed
    end
  end

  def show_state
    case self.aasm_state
      when 'new_order'
        return 'Unfinished'
      when 'payment_pending'
        return 'Payment Pending'
      when 'in_progress'
        return 'In progress'
      when 'delivered'
        return 'Ready for checking'
      when 'correcting'
        return 'Improving'
      when 'completed'
        return 'Done'
      else
        return 'Unfinished'
    end
  end

  def aasm_state_enum
    [['new_order'],['payment_pending'],['in_progress'],['delivered'],['correcting'],['completed']]
  end

  def type_of_paper_array
    return ['Essay (any type)','Admission essay', 'Annotated bibliography', 'Argumentative essay', 'Article review', 'Book/movie review', 'Business plan',
    'Case study', 'Coursework', 'Creative writing', 'Critical thinking', 'Presentation or speech',
    'Research paper', 'Research proposal', 'Term paper', 'Thesis/Dissertation chapter', 'Other']
  end

  def deadline_array
    return ['12 hours', '24 hours','2 days', '3 days', '6 days', '10 days', '14 days']
  end

  def disciplines_list
    return ['Economics', 'History', 'Psychology and Education', 'Political science', 'Sociology', 'Philosophy',
    'Health Care and Life Sciences', 'Computer science', 'Mathematics and Statistics', 'Law', 'Other']
  end

  def self.set_deadline(order)
    deadline = order[:deadline]
    case deadline
      when '12 hours'
        return Time.now + 12.hours
      when '24 hours'
        return Time.now + 24.hours
      when '2 days'
        return Time.now + 2.days
      when '3 days'
        return Time.now + 3.days
      when '6 days'
        return Time.now + 6.days
      when '10 days'
        return Time.now + 10.days
      when '14 days'
        return Time.now + 14.days
      else
        return Time.now + 14.days
    end
  end

  def self.calculate_price(order)
    pay_per_page = 10
    level = order[:academic_level]
    pages = order[:pages].to_i
    deadline = order[:deadline]
    ratio = Rate.where('level = ? AND time = ?',level,deadline).select('rate').first
    price = (ratio.rate*pages*pay_per_page).to_i
    return price
  end

  def get_deadline
     return self.deadline.strftime('%b %d, %Y'), self.deadline.strftime('at %I:%M %p')
  end

  def time_left
    in_hours = TimeDifference.between(Time.now, self.deadline).in_hours
    days = (in_hours/24).floor
    hours = (in_hours%24).floor
    period = "#{days.to_s + 'd ' + hours.to_s + 'h'}"
    return period
  end

  def update_deadline
    in_hours = TimeDifference.between(self.created_at, self.deadline).in_hours.floor
    self.deadline = Time.now + in_hours.hours
    self.save
  end


  def purchase(params)
    response = EXPRESS_GATEWAY.purchase((self.price)*100,
                                        :token => params[:token],
                                        :payer_id => params[:PayerID])
    if response.success?
      self.update_attributes({:updated_at => Time.now, :transaction_details => response.params})
      self.create_completed!# rewrite order status
    end
    response.success?
  end

  before_create do
    self.public_id = SecureRandom.uuid
  end
end